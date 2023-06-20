class FlaggedStory < ActiveRecord::Migration[7.0]
  def change
    create_table :flagged_stories do |t|
      t.string :story_id
      t.string :user_id
      t.timestamps
    end
  end
end
