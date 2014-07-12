class AddCountryToCourt < ActiveRecord::Migration
  def change
    add_column :courts, :country, :string
  end
end
