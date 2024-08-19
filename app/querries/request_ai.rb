# frozen_string_literal: true
class RequestAi
  def initialize(itinerary_id: nil)
    begin
      @itinerary = Itinerary.find(itinerary_id)
    rescue ActiveRecord::RecordNotFound
      @itinerary = nil
    end
  end

  def call
    return if itinerary.nil?
    save_run_request
  end

  private

  attr_accessor :thread, :itinerary

  def create_run
    @create_run ||= Ai::SendMessage.call(message: itinerary.prompt)
  end

  def save_run_request
    RunRequest.create(
      itinerary: itinerary,
      thread_id: create_run[:thread_id],
      run_id: create_run[:run_id]
    )
  end
end