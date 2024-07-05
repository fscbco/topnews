class AddParentToStory < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :parent_id, :integer, null: true
  end
end
