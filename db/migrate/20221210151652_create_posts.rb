class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :author, null: false
      t.string :hn_id, null: false, index: { unique: true }
      t.datetime :hn_created_at, null: false
      t.string :post_type, null: false
      t.string :title, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
