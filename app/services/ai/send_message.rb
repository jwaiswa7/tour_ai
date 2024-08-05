# frozen_string_literal: true
module Ai
  class SendMessage < Base

    def initialize(message:)
      @message = message
      @assistant = Assistant.last
    end

    def call
      build_message
      {
        thread_id: thread_id,
        run_id: run_id
      }
    end

    private

    attr_accessor :assistant, :message

    def thread
      @thread ||= client.threads.create
    end

    def thread_id
      @thread_id ||= thread['id']
    end

    def build_message
      @build_message ||= client.messages.create(
        thread_id: thread_id,
        parameters: {
            role: "user",
            content: message,
        }
      )
    end

    def run_id
      @run_id ||= client.runs.create(thread_id: thread_id,
        parameters: {
            assistant_id: assistant.remote_id
        })['id']
    end
  end
end