class RemoveNullConstraintOnStoryUrl < ActiveRecord::Migration[7.0]
  def change
    change_column_null :stories, :url, true
  end
end
