module Ai
  module ChatBot
    class Base < ApplicationService
      ASSISTANT_ID = Rails.application.credentials.openai.dig(:assistants).dig(:chat_bot).dig(:assistant_id)

      private
      def client
        @client ||= OpenAI::Client.new
      end
    end
  end
end