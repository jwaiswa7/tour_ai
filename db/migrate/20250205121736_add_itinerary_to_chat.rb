class AddItineraryToChat < ActiveRecord::Migration[8.0]
  def change
    add_column :chats, :itinerary, :jsonb
  end
end
