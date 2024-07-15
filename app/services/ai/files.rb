# frozen_string_literal: true
module Ai
  class Files < Base
    def call
      client.files.list
    end

    private

    def add_files
      file = Rails.root.join('lib', 'assets', 'tour_data.json')
      file = File.open(file, 'rb')
      client.files.upload(parameters: { file: file, purpose: "assistants" })
    end
  end
end