# frozen_string_literal: true

class LoadActivitiesJob < ApplicationJob

  self.queue_adapter = :solid_queue

  def perform(chat_id)
    chat = Chat.find(chat_id)
    location = chat.user_details["location"]

    activities = Rails.cache.fetch("activities/#{location}", expires_in: 1.hour) do
      Structure::Activities.call(location: location)
    end

    Turbo::StreamsChannel.broadcast_replace_to(
      "chat-#{chat.id}-edit", # Stream name
      target: "#{chat.id}-activities", # Turbo Frame ID
      partial: "activities/activities", # Partial to render
      locals: { activities: activities }, # Pass data to the partial
      cache: true
    )
  end
end