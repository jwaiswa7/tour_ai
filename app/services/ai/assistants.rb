module Ai
  class Assistants < Base
    def call
      save_assistants
      assistants
    end

    private

    def save_assistants
      assistants['data'].each do |assistant|
        Assistant.find_or_create_by(remote_id: assistant['id'] ) do |a|
          a.name = assistant['name']
          a.description = assistant['description']
          a.model = assistant['model']
          a.instructions = assistant['instructions']
          a.temperature = assistant['temperature']
          a.save
        end
      end
    end

    def assistants
      @assistants ||= client.assistants.list
    end
  end
end