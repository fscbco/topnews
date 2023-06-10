class CreateStorySaves < ActiveRecord::Migration[7.0]
  def change
    create_table :story_saves do |t|
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true
      t.integer :api_id, null: false

      t.timestamps
    end
    add_index :story_saves, [:user_id, :api_id], unique: true
  end
end
