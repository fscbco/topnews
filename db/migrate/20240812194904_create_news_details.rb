class CreateNewsDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :news_details do |t|
      t.string :author # By in HN
      t.integer :comment_count # Decendents in HN
      t.integer :hn_id # HN id
      t.string :url # HN url
      t.integer :score # HN score
      t.string :title # HN story title
      t.string :story_type # HN story type
      t.timestamps
    end
  end
end
