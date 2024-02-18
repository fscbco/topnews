class UpdateStoriesTableData < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :story_type, :string
    change_column :stories, :time, "timestamp with time zone USING to_timestamp(time)"
  end
end
