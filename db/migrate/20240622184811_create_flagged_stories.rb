class CreateFlaggedStories < ActiveRecord::Migration[7.0]
  def change
    create_table :flagged_stories do |t|
      t.integer :story_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
