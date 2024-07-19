class AddArticleIndices < ActiveRecord::Migration[7.0]
  def change
    add_index :articles, :hn_id, unique: true
    add_index :articles, :hn_time
  end
end
