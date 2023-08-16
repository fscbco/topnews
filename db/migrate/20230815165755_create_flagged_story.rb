class CreateFlaggedStory < ActiveRecord::Migration[7.0]
  def change
    create_table :flagged_stories do |t|
      t.string :title
      t.string :url
      t.string :hn_url
      t.integer :hn_id

      t.timestamps
    end
  end
end
