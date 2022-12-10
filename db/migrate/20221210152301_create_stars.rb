class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      t.references :post, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
