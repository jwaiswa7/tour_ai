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

  DESTINATIONS = [
    "Bwindi Impenetrable",
    "Queen Elizabeth National park",
    "Muchison Falls National park",
    "Kibale National park",
    "Lake Mburo National park",
    "Kampala",
    "Kidepo National park",
    "Rwenzori mountains",
    "Entebbe",
    "Lake Bunyonyi"
  ].freeze

  acts_as_taggable_on :interests, :destinations

  scope :recent, -> { order(created_at: :desc) }

  has_one :run_request, dependent: :destroy

  after_create_commit { RequestAiJob.perform_async(id) }

  def prompt
    "Create an itinerary for someone with the hobbies '#{interest_list.join(', ')}', they are interested in the destinations '#{destination_list.join(', ')}'  from #{start_date} to #{end_date}"
  end
end
