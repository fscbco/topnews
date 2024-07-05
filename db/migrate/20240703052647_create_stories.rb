class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :by
      t.boolean :dead
      t.boolean :deleted
      t.integer :descendants
      t.integer :kids, array: true, default: []
      t.integer :parts, array: true, default: []
      t.integer :poll
      t.string :url
      t.integer :score
      t.string :title
      t.string :story_type
      t.integer :time
      t.text :text

      t.timestamps
    end
  end
end
