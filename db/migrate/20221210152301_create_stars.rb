class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      t.references :post, null: false
      t.references :user, null: false

      t.timestamps
    end

    add_index :stars, %i[user_id post_id], unique: true # A user can't star a post more than once
  end
end
