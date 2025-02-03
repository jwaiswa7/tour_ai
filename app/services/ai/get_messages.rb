# frozen_string_literal: true
module Ai
  class GetMessages < Base

    def initialize(thread_id:, run_id:)
      @run_id = run_id
      @thread_id = thread_id
    end

    def call
      return if run_id.nil? || thread_id.nil?
      run_status
      client_response
    end

    private

    attr_accessor :thread_id, :run_id, :run_successfull

    def client_response
      messages = client.messages.list(thread_id: thread_id, parameters: { order: 'desc' })
      messages['data'][0]['content'][0]['text']['value']
    end

    def run_status
      while true do
        response = client.runs.retrieve(id: run_id, thread_id: thread_id)
        status = response['status']

        case status
        when 'queued', 'in_progress', 'cancelling'
          puts 'Sleeping'
          sleep 3 # Wait one second and poll again
        when 'completed'
          @run_successfull = true
          break # Exit loop and report result to user
        when 'requires_action'
          puts 'action required'
          action_required(response)
        when 'cancelled', 'failed', 'expired'
          puts response['last_error'].inspect
          break # or `exit`
        else
          puts "Unknown status response: #{status}"
        end
      end
    end

    def action_required(response)
      tools_to_call = response.dig('required_action', 'submit_tool_outputs', 'tool_calls')

      my_tool_outputs = tools_to_call.map { |tool|
        # Call the functions based on the tool's name
        function_name = tool.dig('function', 'name')
        arguments = JSON.parse(
          tool.dig("function", "arguments"),
          { symbolize_names: true },
        )
    
        tool_output = case function_name
        when "sights"
          sights(**arguments)
        when "hotels"
          hotels(**arguments)
        else 
          'Unknown function'
        end
      
        {
          tool_call_id: tool['id'],
          output: tool_output,
        }
      }

      client.runs.submit_tool_outputs(
        thread_id: thread_id,
        run_id: run_id,
        parameters: { tool_outputs: my_tool_outputs }
      )
    end

    def sights(destination: nil)
      params = {
          engine: "google",
          q: "Top sights in #{destination}",
          api_key: Rails.application.credentials.serp_api_key
        }
      search = search = GoogleSearch.new(params)
      puts "Getting sights for #{destination}"
      top_sights = search.get_hash
      top_sights = top_sights[:top_sights][:sights]&.map{ |sight| { name: sight[:title], description: sight[:description]} }
      {destination: destination, top_sights: top_sights}.to_json
    end

    def hotels(destination: nil)
      params = {
        api_key: Rails.application.credentials.serp_api_key,
        engine: "google_hotels",
        q: "#{destination} Resorts",
        hl: "en",
        gl: "us",
        check_in_date: Date.today.strftime("%Y-%m-%d"),
        check_out_date: (Date.today + 7.days).strftime("%Y-%m-%d"),
        currency: "USD"
      }

      search = GoogleSearch.new(params)

      puts "Getting Hotels for #{destination}"

      hash_results = search.get_hash
      info = hash_results[:properties]&.map{ |property| 
        {
          name: property[:name],
          cordinates: property[:gps_coordinates],
          rate_per_night: property[:rate_per_night],
          amenities: property[:amenities],
          class: property[:hotel_class],
          rating: property[:overall_rating],
          url: property[:link]
        }
      }

      {
        destination: destination,
        hotels: info
    }.to_json
    end
  end
end