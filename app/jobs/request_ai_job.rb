# frozen_string_literal: true
require 'sidekiq'

class RequestAiJob
  include Sidekiq::Job

  def perform(thread_id, message)
    response = RequestAi.new(thread_id: thread_id, message: message).call
    Turbo::StreamsChannel.broadcast_replace_to(
      "#{thread_id}-messages-stream", # Stream name
      target: "#{thread_id}-aiWaiting", # Turbo Frame ID
      partial: "chats/ai_message", # Partial to render
      locals: { message: response } # Pass data to the partial
    )
  end
end
