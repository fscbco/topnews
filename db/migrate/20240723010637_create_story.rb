class CreateStory < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.integer     :story_id
      t.string      :title
      t.string      :url
      t.string      :by
      t.datetime    :time

      t.timestamps
    end

    add_index :stories, :story_id
  end
end
