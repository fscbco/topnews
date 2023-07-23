class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.integer :star_count
      t.text :flagged_by

      t.timestamps
    end
  end
end
