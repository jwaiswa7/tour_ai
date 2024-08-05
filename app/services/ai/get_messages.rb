# frozen_string_literal: true
module Ai
  class GetMessages < Base

    def initialize(itinerary_id: )
      @itinerary = ::Itinerary.find(itinerary_id)
      run_request = @itinerary.run_requests.recent.first
      @thread_id = run_request&.thread_id
      @run_id = run_request&.run_id
    end

    def call
      return if run_id.nil? || thread_id.nil?
      run_status
      return false unless run_successfull
      update_itiernary
    end

    private

    attr_accessor :thread_id, :run_id, :run_successfull, :itinerary

    def update_itiernary
      begin
        itinerary.update(ai_response: client_response)
      rescue ActiveRecordInvalid => e
        puts e.message
      end
    end

    def client_response
      messages = client.messages.list(thread_id: thread_id, parameters: { order: 'desc' })
      message = messages['data'][0]['content'][0]['text']['value']
      message_array = message.split("```")
      json_message = message_array[1].sub(/^json/, '')
      JSON.parse(json_message)
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
          break # Handle tool calls (see below)
        when 'cancelled', 'failed', 'expired'
          puts response['last_error'].inspect
          break # or `exit`
        else
          puts "Unknown status response: #{status}"
        end
      end
    end
  end
end