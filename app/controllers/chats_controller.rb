# frozen_string_literal: true
class ChatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    response = RequestAi.new(thread_id: params[:thread_id], message: params[:message]).call
    respond_to do |format|
      format.json do
        render json: { message: response }
      end
    end
  end
end