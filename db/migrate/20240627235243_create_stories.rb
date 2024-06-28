class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.integer :hacker_news_id
      t.string :author
      t.datetime :time
      t.string :title
      t.string :url

      t.timestamps
    end
    add_index :stories, :hacker_news_id, unique: true
  end
end
