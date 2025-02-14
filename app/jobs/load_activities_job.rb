# frozen_string_literal: true

class LoadActivitiesJob < ApplicationJob

  self.queue_adapter = :solid_queue

  def perform(chat_id)
    chat = Chat.find(chat_id)
    location = chat.user_details["location"]

    activities = Rails.cache.fetch("activities/#{location}", expires_in: 1.hour) do
      Structure::Activities.call(location: location)
    end

    # activities = [{"name"=>"Visit the Uganda Wildlife Education Centre", "description"=>"Explore the wildlife conservation efforts and see various animal species native to Uganda.", "source"=>"https://www.uwec.org"},
    # {"name"=>"Relax at Entebbe Botanical Gardens", "description"=>"Enjoy a peaceful stroll through beautiful gardens featuring diverse plant species and birdlife.", "source"=>"https://www.visituganda.com/entebbe-botanical-gardens"},
    # {"name"=>"Take a Boat Ride on Lake Victoria", "description"=>"Experience the beauty of Lake Victoria with a scenic boat ride, offering views of the surrounding islands.", "source"=>"https://www.lakevictoriatours.com"},
    # {"name"=>"Explore Ngamba Island Chimpanzee Sanctuary", "description"=>"Visit the sanctuary dedicated to the rescue and rehabilitation of orphaned chimpanzees.", "source"=>"https://www.ngambaisland.org"},
    # {"name"=>"Visit the Entebbe Zoo", "description"=>"Discover a variety of animals and learn about conservation efforts at this small but engaging zoo.", "source"=>"https://www.zooentebbe.com"}]

    Turbo::StreamsChannel.broadcast_replace_to(
      "chat-#{chat.id}-edit", # Stream name
      target: "#{chat.id}-activities", # Turbo Frame ID
      partial: "activities/activities", # Partial to render
      locals: { activities: activities }, # Pass data to the partial
      cache: true
    )
  end
end