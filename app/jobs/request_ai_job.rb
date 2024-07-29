require 'sidekiq'

class RequestAiJob
  include Sidekiq::Job

  def perform(itinerary_id)
    RequestAi.new(itinerary_id: @itinerary.id).call
  end
end
