module Ai
  class Prompt < ApplicationService
    include ActionView::Rendering
 
    def initialize(itinerary_id:)
      @itinerary = ::Itinerary.find(itinerary_id)
    end

    def call
      build_prompt
    end

    private
    attr_accessor :itinerary

    def build_prompt
      ApplicationController.render(
        partial: 'itineraries/prompts/template',
        locals: {
          number_of_people: itinerary.number_of_people,
          user_interests: itinerary.interest_list.map(&:humanize),
          destinations: itinerary.destination_list.map(&:humanize),
          number_of_days: ((itinerary.end_date - itinerary.start_date).to_i rescue 7 ),
          budget: itinerary.budget,
          special_requests: 'None'
        }
      )
    end
  end  
end