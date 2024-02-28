class CreateJoinTableArticleUser < ActiveRecord::Migration[7.0]
  def change
    create_join_table :articles, :users do |t|
      # t.index [:article_id, :user_id]
      # t.index [:user_id, :article_id]
    end
  end
end
