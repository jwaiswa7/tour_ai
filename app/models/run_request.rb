# frozen_string_literal: true
class RunRequest < ApplicationRecord
  belongs_to :itinerary

  scope :recent, -> { order(created_at: :desc) }
end
