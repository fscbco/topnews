class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.integer :points
      t.integer :comments_count
      t.integer :hacker_news_id

      t.timestamps
    end
    add_index :stories, :hacker_news_id, unique: true
  end
end
