class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.integer :hn_id
      t.string :title
      t.string :author
      t.datetime :hn_time
      t.string :hn_url
      t.string :hn_type

      t.timestamps
    end

    create_table :articles_users, id: false do |t|
      t.bigint :article_id
      t.bigint :user_id

      t.timestamps
    end

    add_index :articles_users, :article_id
    add_index :articles_users, :user_id
  end

end
