module Structure
  class Activities < ApplicationService
    
    def initialize(location:)
      @location = location
    end

    def call
      location_structure
    end

    private

    attr_reader :location

    def location_structure
      prompt_text = prompt.format(location: location, format_instructions: parser.get_format_instructions)
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
        template: "Generate activities in the location {location} in the following format: {format_instructions}",
        input_variables: ["location", "format_instructions"]
      )
    end



    def json_schema
      {
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
            },
            source: {
              type: "string",
              description: "URL reference to the activity information source"
            }
          }
        }
      }
    end
  end
end