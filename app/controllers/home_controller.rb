# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @thread_id = Ai::ChatBot::Thread.new.call[:thread_id]
  end
end