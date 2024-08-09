class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.integer :hackernewsid, null: false
      t.string :author
      t.string :title, null: false
      t.string :url, null: false
      t.datetime :hn_created_at, null: false
      t.timestamps
    end

    add_index :stories, :hackernewsid, unique: true

  end
end
