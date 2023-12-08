class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.text       :title, null: false
      t.text       :url, null: false
      t.integer    :hacker_news_id, null: false
      t.boolean    :top, null: false, default: false 

      t.timestamps
    end

    add_index :stories, :hacker_news_id, unique: true
  end
end
