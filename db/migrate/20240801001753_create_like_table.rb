class CreateLikeTable < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user
      t.integer :story_id
      t.index [:user_id, :story_id], unique: true
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
