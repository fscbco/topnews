class CreateUserStories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stories do |t|
      t.references :user, index: true, foreign_key: true
      t.references :story, index: true, foreign_key: true
      t.timestamps
    end
    add_index :user_stories, [:story_id, :user_id], unique: true
  end
end
