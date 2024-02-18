class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
    add_index :recommendations, [:user_id, :story_id], unique: true
  end
end
