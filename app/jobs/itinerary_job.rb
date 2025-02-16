# frozen_string_literal: true

class ItineraryJob < ApplicationJob

  self.queue_adapter = :solid_queue
  
  def perform(chat_id)
    chat = Chat.find(chat_id)

    itinerary = Structure::Itinerary.call(itinerary: chat.itinerary_string)

    chat.update(itinerary: itinerary)
  end
end