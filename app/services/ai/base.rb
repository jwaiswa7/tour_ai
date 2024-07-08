module Ai
  class Base < ApplicationService
    
    private
    def client
      @client ||= OpenAI::Client.new
    end
  end
end