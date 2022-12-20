class CreateFeeds < ActiveRecord::Migration[7.0]
  def change
    create_table :feeds do |t|
      t.integer :feed_item_id, null: false
      t.string :source, limit: 32, null: false
      t.integer :source_id, null: false
      t.string :title, null: false
      t.string :url, null: false

      # In the REAL WORLD, this should be in a
      # published_feeds join table...
      #
      # Whether or not this feed has been published
      # (emailed) to the other team members; this
      # will only be true if the feed was recommended
      # by at least 1 team member.
      t.boolean :published, default: false, null: false

      t.timestamps

      # Most of our feeds will NOT be recommended and therefore not
      # published; index on the minority so that when we filter
      # recommended and NON-published feeds, it will be faster.
      t.index :published, where: "published = true"

      # Needed for ActiveRecord#upsert_all and because when
      # we purge the feeds table to make way for new top
      # stories of the day, some of the existing feeds may
      # already be in the table, so there's no need to purge
      # all the rows in the table - just the ones that are NOT
      # recommended (starred) and NOT in the list of
      # top stories returned.
      t.index [:feed_item_id, :source_id], unique: true
    end
  end
end
