class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :story_id
      t.string :story_title
      t.string :story_url

      t.timestamps
    end
  end
end
