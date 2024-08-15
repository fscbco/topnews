class CreateStoryRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :story_rankings, id: false do |t|
      t.integer :story_id
      t.integer :rank
    end

    add_index :story_rankings, [:story_id, :rank], unique: true
  end
end
