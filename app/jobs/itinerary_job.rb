# frozen_string_literal: true

class ItineraryJob < ApplicationJob

  self.queue_adapter = :solid_queue
  
  def perform(itinerary_id)
    itinerary = Itinerary.find(itinerary_id)

    response = Structure::Itinerary.call(itinerary: itinerary.itinerary_string)

    itinerary.update(ai_response: response)

    Turbo::StreamsChannel.broadcast_replace_to(
      "#{itinerary.id}-itinerary", # Stream name
      target: "itinerary-#{itinerary.id}-waiting", # Turbo Frame ID
      partial: "itineraries/response", # Partial to render
      locals: { response: response } # Pass data to the partial
    )
  end
end