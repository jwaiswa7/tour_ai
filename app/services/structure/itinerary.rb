module Structure
  class Itinerary < ApplicationService
    
    def initialize(itinerary:)
      @itinerary = itinerary
    end

    def call
      itinerary_structure
    end

    private

    attr_reader :itinerary

    def itinerary_structure
      prompt_text = prompt.format(itinerary: itinerary, format_instructions: parser.get_format_instructions)
      llm_response = llm.chat(messages: [{role: "user", content: prompt_text}]).completion
      parser.parse(llm_response)
    end


    def llm
      Langchain::LLM::OpenAI.new(api_key: Rails.application.credentials.openai.access_token)
    end

    def parser
      Langchain::OutputParsers::StructuredOutputParser.from_json_schema(json_schema)
    end

    def prompt
      Langchain::Prompt::PromptTemplate.new(
        template: "Generate details of the given itenerary {itinerary} in the following format: {format_instructions}",
        input_variables: ["itinerary", "format_instructions"]
      )
    end



    def json_schema
      {
        type: "array", 
        items: {
          type: "object",
          properties: {
            day: {
              type: "number",
              description: "The day of the itinerary"
            },
            hotel: {
              type: "object",
              properties: {
                name: {
                  type: "string",
                  description: "The name of the hotel"
                },
                address: {
                  type: "string",
                  description: "The address of the hotel"
                },
                url: {
                  type: "string",
                  description: "The url of the hotel"
                },
                rating: {
                  type: "number",
                  description: "The rating of the hotel"
                }
              },
              required: ["name", "address", "rating"],
              additionalProperties: false
            },
            activities: {
              type: "array",
              items: {
                type: "object",
                properties: {
                  name: {
                    type: "string",
                    description: "The name of the activity"
                  },
                  description: {
                    type: "string",
                    description: "The description of the activity"
                  }
                },
                required: ["name", "description"],
                additionalProperties: false
              },
              minItems: 1,
              maxItems: 3,
              description: "A list of activities to do on the day"
            }
          }
        }
      }
    end
  end
end