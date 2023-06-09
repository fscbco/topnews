class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table(:stories, :id => false) do |t|
      t.integer :id, primary_key: true, null: false, unique: true
      t.string :title
      t.string :text
      t.string :url
      t.integer :score
      t.integer :by
      t.integer :descendants
      t.timestamp :time
      t.timestamps
    end
  end
end
