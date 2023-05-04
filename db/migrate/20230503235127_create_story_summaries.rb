class CreateStorySummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :story_summaries do |t|
      t.bigint :story_id
      t.integer :upvotes
      t.string :title
      t.string :url
      t.datetime :time
      t.jsonb :cached_data

      t.timestamps
    end
  end
end
