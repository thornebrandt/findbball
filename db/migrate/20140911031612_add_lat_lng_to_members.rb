class AddLatLngToMembers < ActiveRecord::Migration
    def change
        add_column :members, :lat, :float
        add_column :members, :lng, :float
        add_column :members, :active, :boolean, :default => true
        add_column :members, :registered, :boolean
        add_column :members, :admin, :boolean

        add_column :events, :lat, :float
        add_column :events, :lng, :float
    end
end
