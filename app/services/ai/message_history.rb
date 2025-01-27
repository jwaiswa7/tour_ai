module Ai
  class MessageHistory < Base
    def initialize(thread_id:)
      @thread_id = thread_id
    end

    def call
      messages['data']
    end

    private

    attr_accessor :thread_id

    def messages
      begin
        client.messages.list(thread_id: thread_id, parameters: { order: 'asc' })
      rescue Faraday::ConnectionTimeoutError
        { "data": [] }
      end
    end
  end
end