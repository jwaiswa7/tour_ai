# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @itinerary = Itinerary.new
    @thread_id = Ai::ChatBot::Thread.new.call[:thread_id]
  end
end