# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.bigint :hacker_news_id, null: false
      t.string :by
      t.datetime :published_at
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
