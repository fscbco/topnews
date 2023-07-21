class CreateStarrables < ActiveRecord::Migration[7.0]
  def change
    create_table :starrables do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :story, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :starrables, [:story_id, :user_id], unique: true
  end
end
