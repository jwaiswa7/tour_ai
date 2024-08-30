# frozen_string_literal: true
OpenAI.configure do |config|
  config.access_token =  Rails.application.credentials.openai.access_token
  config.log_errors = true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production.
end