# frozen_string_literal: true
require 'sidekiq'

class RequestAiJob
  include Sidekiq::Job

  def perform(thread_id)
    # RequestAi.new(itinerary_id: itinerary_id).call
    Turbo::StreamsChannel.broadcast_append_to(
      "chats", # Stream name
      target: "#{thread_id}-messages", # Turbo Frame ID
      partial: "chats/ai_message", # Partial to render
      locals: { message: "Hello, cool stuff, AI" } # Pass data to the partial
    )
  end
end
