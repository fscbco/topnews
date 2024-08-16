class ChangeExternalIdToBeIntegerInArticles < ActiveRecord::Migration[7.0]
  def change
    change_column :articles, :external_id, 'integer USING CAST(external_id AS integer)'
  end
end
