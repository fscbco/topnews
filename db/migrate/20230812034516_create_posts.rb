class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :item_id
      t.integer :user_id
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
