class AddNewsStory < ActiveRecord::Migration[7.0]
  def change
    create_table :news_stories, id: false do |t|
      t.integer :id, primary_key: true, null: false
      t.text :title
      t.string :type
      t.string :url
      t.integer :score
      t.jsonb :descendants
      t.string :by
      t.references :pinned_by
      t.integer :time
      t.timestamps
    end
  end
end
