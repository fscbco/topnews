class CreateNewsItems < ActiveRecord::Migration[7.0]
  def change
    create_table :news_items do |t|
      t.string :title
      t.string :item_type
      t.string :url
      t.integer :hacker_news_id

      t.timestamps

      t.index :hacker_news_id
    end
  end
end
