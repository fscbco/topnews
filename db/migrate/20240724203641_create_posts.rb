class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :score, null: false
      t.datetime :posted_at, null: false
      t.string :title, null: false
      t.integer :post_type, null: false
      t.string :url, null: false
      t.references :post_author, foreign_key: true, null: false

      t.timestamps
    end
  end
end
