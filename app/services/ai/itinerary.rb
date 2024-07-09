# frozen_string_literal: true

module Ai
  class Itinerary < ApplicationService
    def call
      # create_assistant
      # client.assistants.list
      # add_files
      # create_vector_store # Failed to create a vector store with ruby gem
      create_thread
    end

    private

    def create_thread
      client.threads.create(
        messages: [
          {
            role: 'user',
            content: 'What do people do at Lake Victoria hotel entebbe, what is the price of a room, and what is the address?',
            attachments: [
              {file_id: 'file-7XNEP8u2PPuBf64hadq7y0Fz', tools: ['file_search']}
            ]
          }
        ]
      )
    end

    def create_vector_store
      client.vector_stores.create(
        parameters: {
          name: "tour ai vector store",
          file_ids: ["file-7XNEP8u2PPuBf64hadq7y0Fz", "file-abE258HRhtoNGEHS7xsHFbIJ"]
        }
      )
    end

    def client
      @client ||= OpenAI::Client.new
    end

    def create_assistant
      # asisstant will search files passed for relevant information
      client.assistants.create(
        parameters: {
          model: 'gpt-4o', # Required.
          name: 'Itinerary Assistant',
          description: 'Helps you plan your itinerary.',
          instructions:,
          tools: [
            { type: 'file_search' }
          ]
        }
      )
    end

    def add_files
      file = Rails.root.join('lib', 'assets', 'tour_data.json')
      file = File.open(file, 'rb')
      client.files.upload(parameters: { file: file, purpose: "assistants" })
    end

    def instructions
      'You are a tour service responsible for creating itinearies for amazing tours. You can ask me to create a tour, add a destination to a tour, remove a destination from a tour, list all tours, list all destinations in a tour, or list all tours that include a specific destination. You can also ask me to provide a summary of a tour, or to provide a summary of all tours.'
    end
  end
end
