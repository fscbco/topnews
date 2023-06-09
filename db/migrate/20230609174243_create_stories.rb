class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :author
      t.string :url
      t.integer :api_id
      t.string :object_type
      t.timestamp :time_posted

      t.timestamps
    end
  end
end
