# frozen_string_literal: true
module Ai
  class VectorStores < Base
    def call
      save_vector_stores
      vector_stores
    end

    private

    def save_vector_stores
      vector_stores['data'].each do |vector_store|
        VectorStore.find_or_create_by(remote_id: vector_store['id'] ) do |vs|
          vs.name = vector_store['name']
          vs.status = vector_store['status']
          vs.file_counts = vector_store['file_counts']['total']
          vs.save
        end
      end
    end

    def vector_stores
      @vector_stores ||= client.vector_stores.list
    end
  end
end