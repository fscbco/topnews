class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      # t.string :author
      t.string :title
      t.string :url
      t.integer :hn_story_id

      t.timestamps
    end

    add_index :stories, :hn_story_id, name: "hn_story_id_ix", unique: true
  end
end
