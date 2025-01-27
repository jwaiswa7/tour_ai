module Ai
  class Runs < Base
    def initialize(thread_id:)
      @thread_id = thread_id
    end

    def call
      runs['data']
    end

    private

    attr_accessor :thread_id

    def runs
      client.runs.list(thread_id: thread_id, parameters: { order: "asc", limit: 3 })
    end
  end
end