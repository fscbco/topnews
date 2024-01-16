class CreateUserStories < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stories do |t|
      t.references :users, index: true, foreign_key: true
      t.references :stories, index: true, foreign_key: true
      t.timestamps
    end
  end
end
