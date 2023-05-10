class CreateFlaggedStories < ActiveRecord::Migration[7.0]
  def change
    create_table "flagged_stories" do |t|
      t.references :users, null: false, foreign_key: true
      t.references :stories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
