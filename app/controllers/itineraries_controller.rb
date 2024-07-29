# frozen_string_literal: true
class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: %i[show edit update destroy]

  def create
    @itinerary = Itinerary.new(itinerary_params)
    respond_to do |format|
      format.turbo_stream do
        if @itinerary.save
          render turbo_stream: turbo_stream.replace(
            'new_itinerary_form', partial: "itineraries/itinerary",
            locals: { itinerary: @itinerary }
          )
        else
          render turbo_stream: turbo_stream.replace(
            @itinerary, partial: "itineraries/form",
            locals: { itinerary: @itinerary }
          )
        end
      end
    end
  end

  def show
    @messages = [{ "id": 1, "content": "Hello" }]
    respond_to do |format|
      format.json do
        render :show, status: :ok
      end
    end
  end

  private

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(:start_date, :end_date, :budget, :accomodation_type, :engagement_level, :weather,
:notes, interest_list: [])
  end
end
