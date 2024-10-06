class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.string :author
      t.datetime :published_at
      t.string :story_type

      t.timestamps
    end
  end
end
