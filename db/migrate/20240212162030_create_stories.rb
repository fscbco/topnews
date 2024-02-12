class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :external_id, null: false, index: { unique: true }
      t.string :title, null: false, index: false
      t.string :author, null: false, index: false

      t.timestamps
    end
  end
end
