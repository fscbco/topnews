class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :author
      t.integer :descendants
      t.integer :article_id
      t.integer :kids, array: true, default: []
      t.integer :score
      t.integer :time
      t.string :title
      t.string :type
      t.string :url
      t.text :content
      t.boolean :bookmarked
      t.references :user, polymorphic: true, null: false

      t.timestamps
    end
  end
end
