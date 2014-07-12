class AddDefaultCountryToCourts < ActiveRecord::Migration
  def change
    change_column :courts, :country, :string, :default => "United States"
  end
end
