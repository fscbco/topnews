class CreateUserLikedStories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :news_details do |t|
      t.index :user_id
      t.index :news_detail_id
      t.timestamps
    end
  end
end
