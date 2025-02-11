# frozen_string_literal: true
class ChatsController < ApplicationController

  before_action :set_chat, only: %i[ show edit update destroy ]

  layout "full_screen", only: :edit

  def create
    @chat = Chat.new(chat_params)
    thread_id = Ai::Thread.call[:thread_id]
    @chat.thread_id = thread_id
    respond_to do |format|
      if @chat.save
        RequestAiJob.perform_later(@chat.thread_id, chat_params[:message])
        @message = chat_params[:message]
        format.turbo_stream
      end
    end
  end

  def edit
    
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