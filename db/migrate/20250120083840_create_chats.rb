class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats, id: :uuid do |t|
      t.string :thread_id

      t.timestamps
    end
  end
end
