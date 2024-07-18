class CreateHackerNewsStories < ActiveRecord::Migration[7.0]
  def change
    create_table :hacker_news_stories do |t|
      t.string :author, null: false
      t.integer :hacker_news_id, null: false
      t.integer :score, null: false
      t.integer :hacker_news_timestamp, null: false
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end

    add_index :hacker_news_stories, :score
    add_index :hacker_news_stories, :hacker_news_timestamp
  end
end
