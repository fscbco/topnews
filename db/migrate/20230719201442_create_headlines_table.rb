class CreateHeadlinesTable < ActiveRecord::Migration[7.0]
  def up
    create_table :headlines do |t|
      t.string "external_id"
      t.string "url", null: false
      t.string "title", null: false
      t.integer "favorites", default: 0

      t.timestamps
    end

    add_index :headlines, :external_id, unique: true
  end

  def down
    drop_table :headlines
  end
end
