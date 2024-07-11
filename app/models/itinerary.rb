class Itinerary < ApplicationRecord
  ACTIVITIES = [
    "City walking tour",
    "Food and wine tasting tour",
    "Adventure sports",
    "Wildlife safari",
    "Boat cruise",
    "Cultural dance show",
    "Cooking class",
    "Historical site visit",
    "Beach day",
    "Mountain hiking"
  ].freeze

  attr_accessor :activities
end
