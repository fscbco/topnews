class CreateFavorite < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end

    add_index :favorites, [:user_id, :story_id], unique: true
  end
end
