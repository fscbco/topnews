class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.integer :score
      t.string :by
      t.string :type
      t.string :_type
      t.string :external_id, null: false, index: { unique: true, name: 'unique_external_id' }
      t.timestamp :time
      t.jsonb :document

      t.timestamps
    end
  end
end
