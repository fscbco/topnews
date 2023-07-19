class AddUserStoryTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stories do |t|
      t.references :user, null: false
      t.references :story, null: false

      t.timestamps null: false
    end
  end
end
