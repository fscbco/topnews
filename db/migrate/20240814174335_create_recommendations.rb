class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.integer :story_id
      t.integer :user_id

      t.timestamps
    end

    add_index :recommendations, [:story_id, :user_id], unique: true
  end
end
