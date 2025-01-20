# frozen_string_literal: true
class ChatsController < ApplicationController

  before_action :set_chat, only: %i[ show edit update destroy ]


  def edit

  end
  def create
    @chat = Chat.new(chat_params)
    respond_to do |format|
      if @chat.save
        format.turbo_stream { redirect_to edit_chat_path(@chat, format: :html) }
      end
    end
    # @thread_id = chat_params[:thread_id]
    # @message = chat_params[:message]
    # RequestAiJob.perform_later(@thread_id, @message)
    # respond_to do |format|
    #   format.json do
    #     render json: { message: response }
    #   end
    #   format.turbo_stream
    # end
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:thread_id, :message)
  end
end