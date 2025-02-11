# frozen_string_literal: true

class RequestAiJob < ApplicationJob

  self.queue_adapter = :solid_queue

  def perform(thread_id, message)
    response = RequestAi.new(thread_id: thread_id, message: message).call    

    chat = Chat.find_by(thread_id: thread_id)

    if response.starts_with? "USER DETAILS"
      Turbo::StreamsChannel.broadcast_replace_to(
        "#{thread_id}-messages-stream", # Stream name
        target: "#{thread_id}-aiWaiting", # Turbo Frame ID
        partial: "chats/ai_building_itinerary", # Partial to render
        locals: { message: "Building itinerary", thread_id: thread_id } # Pass data to the partial
      )
      structured_response = Structure::UserDetails.call(user_details: response)
      chat.update(user_details: structured_response)

      Turbo::StreamsChannel.broadcast_replace_to(
        "#{thread_id}-messages-stream", # Stream name
        target: "#{thread_id}-aiWaiting", # Turbo Frame ID
        partial: "chats/ai_building_itinerary", # Partial to render
        locals: { message: "<a href='/chats/#{chat.id}/edit'>View itinerary</a>", thread_id: thread_id } # Pass data to the partial
      )
    else 
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
end