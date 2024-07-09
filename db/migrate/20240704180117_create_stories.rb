class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url

      t.timestamps
    end

    add_index :stories, [:title, :url], unique: true
  end
end
