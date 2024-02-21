class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references(:user, foreign_key: true, index: true, null: false)
      t.references(:story, foreign_key: true, index: true, null: false)
      t.timestamps
    end
  end
end
