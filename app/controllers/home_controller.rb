# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @chat = Chat.new
  end
end