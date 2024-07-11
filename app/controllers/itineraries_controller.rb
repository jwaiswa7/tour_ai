class ItinerariesController < ApplicationController
  def create
    # render turbo 
    @itinerary = Itinerary.new(itinerary_params)
    respond_to do |format|
      format.turbo_stream do
        if @itinerary.save
          render turbo_stream: turbo_stream.replace("itinerary", partial: "itineraries/itinerary", locals: { itinerary: @itinerary })
        else
          render turbo_stream: turbo_stream.replace(@itinerary, partial: "itineraries/form", locals: { itinerary: @itinerary })
        end
      end
    end
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:start_date, :end_date, :budget, :accomodation_type, :engagement_level, :weather, :notes)
  end
end
