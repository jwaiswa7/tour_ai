# frozen_string_literal: true
class Assistant < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "instructions", "model", "name", "remote_id", "temperature", "updated_at"]
  end
end
