class CreateItineraries < ActiveRecord::Migration[8.0]
  def change
    create_table :itineraries, id: :uuid do |t|
      t.string :country
      t.string :city
      t.integer :number_of_people
      t.date :start_date
      t.date :end_date
      t.integer :budget
      t.jsonb :ai_response

      t.timestamps
    end
  end
end
