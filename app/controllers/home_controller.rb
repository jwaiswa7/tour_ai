# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @itinerary = Itinerary.new
  end
end