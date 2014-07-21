class AddLocationToCourt < ActiveRecord::Migration
  def change
    remove_column :courts,    :address
    remove_column :courts,    :city
    remove_column :courts,    :state
    remove_column :courts,    :zip
    remove_column :courts,    :country
    add_column    :courts,    :location,          :string,      limit: 200
    add_column    :courts,    :website,           :string,      limit: 512
    change_column :courts,    :skill_level,       :integer,     limit: 1     # One byte, up to 127
    change_column :courts,    :best_time,         :integer,     limit: 1
    add_column    :courts,    :best_time_ampm,    :string,      limit: 2
    add_column    :courts,    :best_day,          :string,      limit: 10
    add_column    :courts,    :hours_open,        :integer,     limit: 1
    add_column    :courts,    :hours_open_ampm,   :string,      limit: 2
    add_column    :courts,    :hours_closed,      :integer,     limit: 1
    add_column    :courts,    :hours_closed_ampm, :string,      limit: 2
  end
end
