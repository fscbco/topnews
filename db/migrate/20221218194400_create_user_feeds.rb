class CreateUserFeeds < ActiveRecord::Migration[7.0]
  def change
    create_join_table(:users, :feeds, table_name: :user_feeds) do |t|
      t.index :user_id
      t.index :feed_id

      t.timestamps
    end
  end
end
