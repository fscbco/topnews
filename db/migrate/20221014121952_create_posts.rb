class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :username
      t.integer :votes
      t.string :url
      t.integer :post_id

      t.timestamps
    end
  end
end
