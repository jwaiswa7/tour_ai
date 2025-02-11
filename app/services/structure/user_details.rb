module Structure
  class UserDetails < ApplicationService
    
    def initialize(user_details:)
      @user_details = user_details
    end

    def call
      user_details_structure
    end

    private

    attr_reader :user_details

    def user_details_structure
      prompt_text = prompt.format(user_details: user_details, format_instructions: parser.get_format_instructions)
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
        template: "Generate details of the given itenerary {user_details} in the following format: {format_instructions}",
        input_variables: ["user_details", "format_instructions"]
      )
    end



    def json_schema
      {
        type: "object",
        properties: {
          location: {
            type: "string",
            description: "The place to visit for the user"
          },
          date: {
            type: "string",
            description: "The date to visit for the user in the format dd/mm/yyyy"
          },
          duration: {
            type: "number",
            description: "The duration of the trip"
          },
          number_of_people: {
            type: "number",
            description: "The number of people in the trip"
          },
          budget_estimate: {
            type: "string",
            description: "The budget estimate for the trip"
          }
        }
      }
    end
  end
end