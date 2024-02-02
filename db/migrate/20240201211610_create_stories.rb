class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :by
      t.integer :score
      t.string :url
      t.integer :time
      t.timestamps
    end
  end
end
