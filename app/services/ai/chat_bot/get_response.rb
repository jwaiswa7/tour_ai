module Ai
  module ChatBot
    class GetResponse < Ai::Base
      def initialize(thread_id:)
        @thread_id = thread_id
      end

      def call
        get_response
      end

      private
      
      attr_accessor :thread_id
    end
  end
end