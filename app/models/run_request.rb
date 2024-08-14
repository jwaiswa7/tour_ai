# frozen_string_literal: true
class RunRequest < ApplicationRecord
  belongs_to :itinerary

  scope :recent, -> { order(created_at: :desc) }

  def self.ransackable_associations(auth_object = nil)
    ["itinerary"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "itinerary_id", "message", "run_id", "thread_id", "updated_at"]
  end
end
