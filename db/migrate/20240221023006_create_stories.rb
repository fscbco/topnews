# frozen_string_literal: true

class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.jsonb(:raw_data)
      t.integer(:hacker_news_id, null: false)

      t.timestamps
    end
  end
end
