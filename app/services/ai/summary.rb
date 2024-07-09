# frozen_string_literal: true

module Ai
  class Summary < ApplicationService
    def initialize(text:)
      @text = text
      @client = OpenAI::Client.new
    end

    def call
      call_openai
    end

    private

    attr_accessor :text, :client

    def call_openai
      response = client.chat(
        parameters: {
          model: 'gpt-4o', # Required.
          messages: [message], # Required.
          temperature: 0.7
        }
      )

      response = JSON.parse(response.to_json, object_class: OpenStruct)

      response.choices[0].message.content
    end

    def message
      { role: 'user', content: build_prompt }
    end

    def build_prompt
      "Summarize the following text to at most 30 words: \
      *#{text}*"
    end
  end
end
