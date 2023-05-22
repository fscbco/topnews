class CreateFlaggedStories < ActiveRecord::Migration[7.0]
  def change
    create_table :flagged_stories do |t|
      t.string :title
      t.string :by
      t.integer :external_id
      t.integer :score
      t.string :url

      t.timestamps
    end
  end
end
