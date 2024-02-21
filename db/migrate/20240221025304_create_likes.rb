class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references(:user, foreign_key: true, index: true)
      t.references(:story, foreign_key: true, index: true)
      t.timestamps
    end
  end
end
