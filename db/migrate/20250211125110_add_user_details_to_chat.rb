class AddUserDetailsToChat < ActiveRecord::Migration[8.0]
  def change
    add_column :chats, :user_details, :jsonb
  end
end
