class CreateItineraries < ActiveRecord::Migration[7.0]
  def change
    create_table :itineraries, id: :uuid do |t|
      t.date :start_date
      t.date :end_date
      t.string :budget
      t.string :accomodation_type
      t.string :engagement_level
      t.string :weather
      t.text :notes

      t.timestamps
    end
  end
end
