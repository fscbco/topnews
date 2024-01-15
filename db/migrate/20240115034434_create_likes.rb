class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :hacker_news_story, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :likes, [:hacker_news_story_id, :user_id], unique: true, name: "index_hacker_news_story_id_and_user_id"
  end
end
