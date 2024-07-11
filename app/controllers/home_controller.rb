class HomeController < ApplicationController
  def index
    @itinerary = Itinerary.new
  end
end