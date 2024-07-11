class CreateRunRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :run_requests, id: :uuid do |t|
      t.string :thread_id
      t.string :run_id
      t.text :message

      t.timestamps
    end
  end
end
