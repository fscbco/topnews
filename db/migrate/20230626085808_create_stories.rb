class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :source_url
      t.string :image_url
      t.string :username
      t.text :content
      t.integer :user_id
      t.string :title
      t.boolean :is_starred
      t.integer :stars
      t.float :ranking

      t.timestamps
    end
  end
end
