class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      # Make sure we don't have null on any fields and that the id is unique to prevent
      # having multiple of the same stories. 
      t.integer :hacker_news_id, null: false, unique: true
      # Title / URL will be an issue if the stories / url changes on
      # hackernews and we'd need a way to update it. Potentially running a sidekick job to check.
      # But under the assumption it doesn't change, I'll add it here so that we don't need to make additional
      # requests to hackernews for each story when getting our list.  
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end
    # I'm adding an index to stories to improve query time
    add_index :stories, :hacker_news_id, unique: true
  end
end
