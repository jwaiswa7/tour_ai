class QuestionsController < ApplicationController

  def index

  end

  def create

  end

  private

  def question_params
    params.require(:question).permit(:question)
  end
end
