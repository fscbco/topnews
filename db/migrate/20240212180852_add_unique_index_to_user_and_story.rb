class AddUniqueIndexToUserAndStory < ActiveRecord::Migration[7.0]
  def change
    add_index :story_stars, [:user_id, :story_id], unique: true
  end
end
