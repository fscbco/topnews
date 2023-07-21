class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :story_id, null: false
      t.string :title
      t.string :author
      t.integer :score
      t.string :url
      t.datetime :time

      t.timestamps
    end

    add_index :stories, :story_id, unique: true
  end
end
