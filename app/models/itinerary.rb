# frozen_string_literal: true
class Itinerary < ApplicationRecord
  PLACES_TO_VISIT = JSON.parse(File.read(Rails.root.join('lib', 'assets', 'places_to_visit.json')),
symbolize_names: true).freeze

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

  acts_as_taggable_on :interests, :destinations

  scope :recent, -> { order(created_at: :desc) }

  scope :created_today, -> {
    where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }

  has_many :run_requests, dependent: :destroy

  # after_create_commit { RequestAiJob.perform_async(id) }

  def self.places_to_visit
    PLACES_TO_VISIT.sample(6)
  rescue JSON::ParserError => e
    Rails.logger.error("JSON parsing error: #{e.message}")
    []
  end

  def activities_from_places_to_visit
    PLACES_TO_VISIT.select{ |place|
      destination_list.include?(place[:key]) }.map{ |place| place[:activities]
    }.flatten.uniq
  end

  def self.ransackable_attributes(auth_object = nil)
    ["accomodation_type", "ai_response", "budget", "created_at", "end_date", "engagement_level", "id", "notes",
"number_of_people", "start_date", "updated_at", "weather" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def prompt
    Ai::Prompt.call(itinerary_id: id)
  end
end
