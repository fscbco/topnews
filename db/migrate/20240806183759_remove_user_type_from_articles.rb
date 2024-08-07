class RemoveUserTypeFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_column :articles, :user_type, :string
  end
end
