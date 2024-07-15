# frozen_string_literal: true
class ItinerariesController < ApplicationController
  def create
    # render turbo
    @itinerary = Itinerary.new(itinerary_params)
    respond_to do |format|
      format.turbo_stream do
        if @itinerary.save
          response = RequestAi.new.call
          render turbo_stream: turbo_stream.replace("itinerary", partial: "itineraries/itinerary",
locals: { response: response })
        else
          render turbo_stream: turbo_stream.replace(@itinerary, partial: "itineraries/form",
locals: { itinerary: @itinerary })
        end
      end
    end
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:start_date, :end_date, :budget, :accomodation_type, :engagement_level, :weather,
:notes, interest_list: [])
  end
end
