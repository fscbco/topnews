class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.string :author
      t.datetime :posted_at
      t.integer :reference_id, null: false
      t.timestamps
    end
    add_index :stories, :reference_id, unique: true
  end
end
