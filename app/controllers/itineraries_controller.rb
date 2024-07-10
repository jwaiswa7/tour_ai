class ItinerariesController < ApplicationController
  def create
    # render turbo 
    @itinerary = Itinerary.new(itinerary_params)
    if @itinerary.save
      redirect_to root_path
    else
      render turbo_stream: turbo_stream.replace(@itinerary, partial: "itineraries/form", locals: { itinerary: @itinerary })
    end
  end

  private

  def itinerary_params
    params.require(:itinerary).permit(:start_date, :end_date, :budget, :accomodation_type, :engagement_level, :weather, :notes)
  end
end
