class QuestionsController < ApplicationController

  def index

  end

  def create
    # openai_client = OpenAI::Client.new
    # response = openai_client.chat(parameters: {
    #   model: "gpt-3.5-turbo",
    #   messages: [{ role: "user", content: 'What is the capital city of Uganda' }],
    #   temperature: 0.5,
    # })
    # @answer = response
    @answer = "Kampala"
  end

  private

  def question_params
    params.require(:question).permit(:question)
  end
end
