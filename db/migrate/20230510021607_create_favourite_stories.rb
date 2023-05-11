class CreateFavouriteStories < ActiveRecord::Migration[7.0]
  def change
    create_table :favourite_stories do |t|
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
