module Ai
  module ChatBot 
    class Thread < Ai::Base
      ASSISTANT_ID = Rails.application.credentials.openai.dig(:assistants).dig(:chat_bot).dig(:assistant_id)

      def call
        { thread_id: thread_id }
      end

      private

      def thread
        @thread ||= client.threads.create
      end

      def thread_id
        thread['id']
      end
    end
  end
end