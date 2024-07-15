# frozen_string_literal: true
class Itinerary < ApplicationRecord
  ACTIVITIES = [
    "Bird Watching",
    "Wildlife Enthusiast",
    "Gardening and Botany",
    "Boating and Fishing",
    "Hiking and Nature Walks",
    "Historical Interests",
    "Photography",
    "Golf",
    "Fishing",
    "Cycling",
    "Water Sports",
    "Relaxation and Wellness",
    "Volunteering"
  ].freeze

  acts_as_taggable_on :interests

  scope :recent, -> { order(created_at: :desc) }

  def prompt
    "Create an itinerary for someone with the hobbies ' #{interest_list.join(', ')} ' in Entebbe from #{start_date} to #{end_date}"
  end
end
