class CreateVectorStores < ActiveRecord::Migration[7.0]
  def change
    create_table :vector_stores, id: :uuid do |t|
      t.string :name
      t.string :status
      t.string :remote_id
      t.integer :file_counts

      t.timestamps
    end
  end
end
