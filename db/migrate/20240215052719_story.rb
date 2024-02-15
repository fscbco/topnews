class Story < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :by
      t.text :text
      t.string :url
      t.integer :score
      t.integer :time

      t.timestamps
    end
  end
end
