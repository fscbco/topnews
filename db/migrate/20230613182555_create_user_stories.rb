class CreateUserStories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stories do |t|
      t.bigint "user_id"
      t.bigint "story_id"

      t.index ["story_id"], name: "index_user_stories_on_story_id"
      t.index ["user_id"], name: "index_user_stories_on_user_id"

      t.timestamps
    end
  end
end
