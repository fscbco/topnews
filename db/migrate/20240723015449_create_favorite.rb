class CreateFavorite < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.integer :user_id,   null: false
      t.integer :story_id,  null: false
      t.timestamps
    end

    add_index :favorites, [:story_id, :user_id]
  end
end
