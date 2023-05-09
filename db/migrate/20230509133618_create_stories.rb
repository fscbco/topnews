class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table ('feed.stories') do |t|
      t.string :title
      t.string :url
      t.integer :hn_id

      t.timestamps
    end
  end
end
