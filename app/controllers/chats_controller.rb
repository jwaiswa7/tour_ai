# frozen_string_literal: true
class ChatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    respond_to do |format|
      format.json do
        render json: { message: 'Testing' }
      end
    end
  end
end