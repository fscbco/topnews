class CreateStoryStars < ActiveRecord::Migration[7.0]
  def change
    create_table :story_stars do |t|
      t.belongs_to :user, null: false, index: true
      t.belongs_to :story, null: false, index: true

      t.timestamps
    end
  end
end
