class CreateHackerNewsStories < ActiveRecord::Migration[7.0]
  def change
    create_table :hacker_news_stories do |t|
      t.string :by
      t.integer :score
      t.datetime :time
      t.string :title
      t.string :url
    end
  end
end
