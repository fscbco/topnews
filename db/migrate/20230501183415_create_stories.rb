class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.integer :hn_story_id
      t.string :title
      t.string :by
      t.datetime :time
      t.string :url

      t.timestamps
    end
  end
end
