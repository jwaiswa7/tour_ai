# frozen_string_literal: true
class HomeController < ApplicationController
  def index
    @itinerary = Itinerary.new
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def thread
    @thread ||= client.threads.create
  end

  def run_id
    @run_id ||= client.runs.create(thread_id: thread_id,
      parameters: {
          assistant_id: assistant.remote_id
      })['id']
  end
end