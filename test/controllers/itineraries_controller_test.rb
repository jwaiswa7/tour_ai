# frozen_string_literal: true
require "test_helper"

class ItinerariesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get itineraries_create_url
    assert_response :success
  end
end
