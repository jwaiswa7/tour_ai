# frozen_string_literal: true
class ChatsController < ApplicationController
  def create
    # response = RequestAi.new(thread_id: params[:thread_id], message: params[:message]).call
    @thread_id = chat_params[:thread_id]
    @message = chat_params[:message]
    RequestAiJob.perform_async(@thread_id)
    respond_to do |format|
      format.json do
        render json: { message: response }
      end
      format.turbo_stream
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:thread_id, :message)
  end
end