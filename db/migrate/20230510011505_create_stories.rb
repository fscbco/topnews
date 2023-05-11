class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.string :author
      t.integer :score
      t.integer :story_id
      t.datetime :story_time

      t.timestamps
    end
  end
end
