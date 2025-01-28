module Ai
  module Gemni
    class Hotels < ApplicationService
      API_KEY = Rails.application.credentials.gemni.access_token
      def initialize(location:)
        @location = location
      end

      def call
        JSON.parse hotels['candidates'][0]['content']['parts'][0]['text']
      end

      private

      attr_accessor :location

      def hotels
        url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=#{API_KEY}"

        headers = {
          "Content-Type" => "application/json"
        }

        body = {
          "contents": [{
            "parts":[
              {"text": "List 5 hotels in #{location}, return the cost per night and rating"}
            ]
          }],
          "generationConfig": {
            "response_mime_type": "application/json",
            "response_schema": {
              "type": "ARRAY",
              "items": {
                "type": "OBJECT",
                "properties": {
                  "hotel_name": {"type":"STRING"},
                  "cost": {"type":"STRING"},
                  "rating": {"type":"STRING"},
                }
              }
            }
          }
        }

        HTTParty.post(url, body: body.to_json, headers: headers).parsed_response
      end
    end
  end
end