class CreateJoinTableUsersArticles < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :articles, table_name: 'user_articles', column_options: { null: false, foreign_key: true } do |t|
      t.index [:user_id, :article_id]
      t.index [:article_id, :user_id]
      t.index :user_id
      t.index :article_id
    end
  end
end
