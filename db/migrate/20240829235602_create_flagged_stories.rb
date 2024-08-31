class CreateFlaggedStories < ActiveRecord::Migration[7.0]
  def change
    create_table :flagged_stories do |t|
      t.string :title
      t.string :url

      t.timestamps
    end

    create_join_table :flagged_stories, :users do |t|
      t.index [:flagged_story_id, :user_id], unique: true
    end
    
  end
end
