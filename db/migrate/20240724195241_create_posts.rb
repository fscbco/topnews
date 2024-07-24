class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :score, null: false
      t.datetime :time, null: false
      t.string :title, null: false
      t.integer :type, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
