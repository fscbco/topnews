class CreateStoriesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string "title"
      t.string "url"
      t.boolean "starred", default: false
      t.bigint "hacker_news_story_id"

      t.timestamps
    end
  end
end
