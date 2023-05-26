class CreateStories < ActiveRecord::Migration[7.0]

  def change
    create_table :stories, primary_key: :hn_id do |t|
      t.string :hn_by
      t.integer :hn_descendants
      t.integer :hn_kids, array: true
      t.integer :hn_score
      t.datetime :hn_time
      t.string :hn_title
      t.string :hn_type
      t.string :hn_url
      t.string :hn_text

      t.timestamps
    end

    create_join_table :users, :stories, table_name: :likes do |t|
      t.index :user_id
      t.index :story_id
    end
  end
end
