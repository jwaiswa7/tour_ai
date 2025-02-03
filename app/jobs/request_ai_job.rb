# frozen_string_literal: true

class RequestAiJob < ApplicationJob

  self.queue_adapter = :solid_queue

  def perform(thread_id, message)
    # response = RequestAi.new(thread_id: thread_id, message: message).call
    sleep(5)
    response = "Hello"
    
    chat = Chat.find_by(thread_id: thread_id)

    Turbo::StreamsChannel.broadcast_replace_to(
      "#{thread_id}-messages-stream", # Stream name
      target: "#{thread_id}-aiWaiting", # Turbo Frame ID
      partial: "chats/ai_response", # Partial to render
      locals: { message: response } # Pass data to the partial
    )

    Turbo::StreamsChannel.broadcast_replace_to(
      "#{thread_id}-messages-stream", # Stream name
      target: "#{thread_id}-chat-form", # Turbo Frame ID
      partial: "chats/form", # Partial to render
      locals: { chat: chat } # Pass data to the partial
    )
  end
end
