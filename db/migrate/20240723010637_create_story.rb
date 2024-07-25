class CreateStory < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.integer     :external_story_id, null: false
      t.string      :title,             null: false
      t.string      :url,               null: false
      t.string      :by,                null: false
      t.datetime    :time,              null: false

      t.timestamps
    end

    add_index :stories, :external_story_id
  end
end
