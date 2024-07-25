class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.integer :page_id, null: false, index: true
      t.string :title
      t.integer :votes, default: 0

      t.timestamps
    end
  end
end
