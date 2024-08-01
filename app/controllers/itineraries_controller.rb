# frozen_string_literal: true
class ItinerariesController < ApplicationController
  before_action :set_itinerary, only: %i[show edit run update destroy]
  before_action :set_run_request, only: %i[run]

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

  end

  def run
    respond_to do |format|
      format.json do
        if @run_request.present?
          run = Ai::GetMessages.new(thread_id: @run_request.thread_id, run_id: @run_request.run_id).call
          if run
            render :run, status: :ok
          else
            render :show, status: :unprocessable_entity
          end
        else
          render :show, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def set_run_request
    @run_request = @itinerary.run_request
  end

  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  def itinerary_params
    params.require(:itinerary).permit(
      :start_date,
      :end_date,
      :budget,
      :accomodation_type,
      :engagement_level,
      :weather,
      :notes,
      interest_list: [],
      destination_list: []
    )
  end
end
