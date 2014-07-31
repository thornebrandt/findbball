class AddLatLngToCourts < ActiveRecord::Migration
  def change
    add_column :courts, :lat, :float
    add_column :courts, :lng, :float
  end
end
