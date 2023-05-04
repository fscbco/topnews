class CreateUserStories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stories do |t|
      t.bigint :story_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
