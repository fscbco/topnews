class AddStoryTable < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.bigint :external_id, null: false

      t.timestamps null: false
    end

    add_index :stories, :external_id, unique: true
  end
end
