class Chat < ApplicationRecord

  attr_accessor :message

 # call the create itinerary job once the user_details has been saved
 before_save :save_itinerary_if_user_details_changed
  

  def itinerary_string
    <<~ITINERARY
      Destination: #{user_details["location"]}
      Duration: #{user_details["duration"]}
      Budget: #{user_details["budget_estimate"]}
      Number of people: #{user_details["number_of_people"]}
    ITINERARY
  end

  private

  def save_itinerary_if_user_details_changed
    if user_details_changed?
      puts "Calling itinerary job"
      ItineraryJob.perform_later(id)
    end
  end
end
