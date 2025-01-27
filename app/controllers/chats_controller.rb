# frozen_string_literal: true
class ChatsController < ApplicationController

  before_action :set_chat, only: %i[ show edit update destroy ]

  layout "full_screen", only: :edit

  def create
    @chat = Chat.new(chat_params)
    respond_to do |format|
      if @chat.save
        session[:message] = @chat.message
        format.turbo_stream { redirect_to edit_chat_path(@chat, format: :html) }
      end
    end
  end

  def edit
    if session.key?(:message)
      @message = session[:message]
      RequestAiJob.perform_later(@chat.thread_id, @message)
      session.delete(:message)
    else
      LoadMessagesJob.perform_later(@chat.thread_id)
    end
  end

  def update
    @message = chat_params[:message]
    RequestAiJob.perform_later(@chat.thread_id, @message)
  end

  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:thread_id, :message)
  end
end