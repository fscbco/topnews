class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      t.references :user, foreign_key: true
      t.references :story, foreign_key: true
      t.timestamps
    end

    add_index :stars, [:user_id, :story_id], unique: true
  end
end
