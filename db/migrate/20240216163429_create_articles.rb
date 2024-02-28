class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :author
      t.integer :article_foreign_id
      t.integer :score
      t.string :text
      t.datetime :time
      t.string :title
      t.string :article_type
      t.string :url

      t.timestamps
    end
  end
end
