class Itinerary < ApplicationRecord

  validates :country, :city, :number_of_people, :start_date, :end_date, presence: true

  attr_accessor :random_id

  def itinerary_string
    <<~ITINERARY
      Country: #{country}
      City: #{city}
      Number of people: #{number_of_people}
      Start date: #{start_date}
      End date: #{end_date}
    ITINERARY
  end
end
