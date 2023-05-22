class AddNamesToNews < ActiveRecord::Migration[7.0]
  def change
    add_column :news, :names, :string, array: true, default: []
  end
end
