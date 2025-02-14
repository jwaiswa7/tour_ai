class Chat < ApplicationRecord

  attr_accessor :message

  def itinerary_string
    <<~ITINERARY
      Destination: #{user_details["location"]}
      Duration: #{user_details["duration"]}
      Budget: #{user_details["budget_estimate"]}
      Number of people: #{user_details["number_of_people"]}
    ITINERARY
  end
end
