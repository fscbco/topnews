class CreateSourcesStoriesUserStoriesTopStories < ActiveRecord::Migration[7.0]
  def change
    create_table :sources do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :stories do |t|
      t.string :title,       null: false
      t.string :author,      null: false
      t.string :url
      t.string :external_id, null: false
      t.references :source,  null: false
      t.string :source_time, null: false

      t.timestamps
    end

    add_index :stories, [:external_id, :source_id], unique: true

    create_table :user_stories do |t|
      t.references :user
      t.references :story

      t.timestamps
    end

    create_table :top_stories do |t|
      t.string :external_ids, array: true, null: false
      t.references :source,                null: false
      
      t.timestamps
    end
  end
end
