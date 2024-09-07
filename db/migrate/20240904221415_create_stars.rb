class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      # This is just a pivot table to map stars to stories
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
    # Add an index on stars because there could potentially be lots of stars on a story
    add_index :stars, [:user_id, :story_id], unique: true
  end
end
