class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.string :author
      t.string :url, null: false
      t.integer :api_id, null: false, unique: true
      t.string :object_type
      t.timestamp :time_posted

      t.timestamps
    end

    add_index :stories, :api_id, unique: true
  end
end
