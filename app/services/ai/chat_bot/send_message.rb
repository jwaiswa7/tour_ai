module Ai
  module ChatBot
    class SendMessage < Ai::Base
      def initialize(thread_id: ,message:)
        @thread_id = thread_id
        @message = message
      end

      def call
        send_message
      end

      private

      attr_accessor :thread_id, :run_id, :message

      def send_message
        build_message
        run_id
        running
        retirieve_response
      end

      def build_message
        client.messages.create(
          thread_id: thread_id,
          parameters: {
              role: "user",
              content: message,
          }
        )
      end

      def run_id
        @run_id ||= client.runs.create(thread_id: thread_id,
          parameters: {
              assistant_id: Ai::ChatBot::Base::ASSISTANT_ID
        })['id']
      end

      def retirieve_response
        client.messages.list(thread_id: thread_id, parameters: { order: 'desc' })
      end

      def running
        while true do
          run = client.runs.retrieve(thread_id: thread_id, id: run_id)
          status = run['status']

          case status
          when 'queued', 'in_progress', 'cancelling'
            puts 'Sleeping'
            sleep 3 # Wait one second and poll again
          when 'completed'
            puts 'completed'
            break # Exit loop and report result to user
          when 'requires_action'
            puts 'action required'
            break # Handle tool calls (see below)
          when 'cancelled', 'failed', 'expired'
            puts run['last_error'].inspect
            break # or `exit`
          else
            puts "Unknown status response: #{status}"
          end
        end
      end
    end
  end
end