module Ai
  class Assistants < Base
    def call
      client.assistants.list
    end
  end
end