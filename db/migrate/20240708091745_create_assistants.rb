class CreateAssistants < ActiveRecord::Migration[7.0]
  def change
    create_table :assistants, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :remote_id
      t.string :model
      t.text :instructions
      t.decimal :temperature

      t.timestamps
    end
  end
end
