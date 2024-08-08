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

  acts_as_taggable_on :interests, :destinations

  scope :recent, -> { order(created_at: :desc) }

  scope :created_today, -> {
    where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
  }

  has_many :run_requests, dependent: :destroy

  after_create_commit { RequestAiJob.perform_async(id) }

  def self.places_to_visit
    file_path = Rails.root.join('lib', 'assets', 'places_to_visit.json')
    if File.exist?(file_path)
      file = File.read(file_path)
      JSON.parse(file, symbolize_names: true).sample(6)
    else
      Rails.logger.error("File not found: #{file_path}")
      []
    end
  rescue JSON::ParserError => e
    Rails.logger.error("JSON parsing error: #{e.message}")
    []
  end

  def prompt
    "Create an itinerary for someone with the hobbies '#{interest_list.join(', ')}', they are interested in the destinations '#{destination_list.join(', ')}'  from #{start_date} to #{end_date}"
  end
end
