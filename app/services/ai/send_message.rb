module Ai
  class SendMessage < Base

    def initialize
      @assistant = Assistant.last
    end

    def call
      message
      {
        thread_id: thread_id,
        run_id: run_id
      }
    end

    private

    attr_accessor :assistant, :vector_store

    def thread
      @thread ||= client.threads.create
    end

    def thread_id
      @thread_id ||= thread['id']
    end

    def message
      @message ||= client.messages.create(
        thread_id: thread_id,
        parameters: {
            role: "user",
            content: "List for me 5 tour destinations in Entebbe Uganda.  Return some information of about 30 words on Lake Victoria Hotel and price for a room",
        })
    end

    def run_id
      @run_id ||= client.runs.create(thread_id: thread_id,
        parameters: {
            assistant_id: assistant.remote_id
        })['id']
    end
  end
end