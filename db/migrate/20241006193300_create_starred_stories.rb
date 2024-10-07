class CreateStarredStories < ActiveRecord::Migration[7.0]
  def change
    create_table :starred_stories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :story_id, null: false

      t.timestamps
    end

    add_index :starred_stories, [:user_id, :story_id], unique: true
  end
end
