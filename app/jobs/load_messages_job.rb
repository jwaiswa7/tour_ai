# frozen_string_literal: true

class LoadMessagesJob < ApplicationJob

  self.queue_adapter = :solid_queue

  def perform(thread_id)
    messages = Ai::MessageHistory.new(thread_id: thread_id).call
    
    Turbo::StreamsChannel.broadcast_replace_to(
      "#{thread_id}-messages-stream", # Stream name
      target: "#{thread_id}-messages", # Turbo Frame ID
      partial: "chats/messages", # Partial to render
      locals: { messages: messages, thread_id: thread_id } # Pass data to the partial
    )
  end
end