class CreateStoryStars < ActiveRecord::Migration[7.0]
  def change
    create_table :story_stars do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :story_id, null: false

      t.index %i[user_id story_id], unique: true
    end
  end
end
