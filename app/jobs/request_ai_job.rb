# frozen_string_literal: true
require 'sidekiq'

class RequestAiJob
  include Sidekiq::Job

  def perform(itinerary_id)
    RequestAi.new(itinerary_id: itinerary_id).call
  end
end
