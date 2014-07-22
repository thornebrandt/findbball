class ChangeCourtTimeAttributeNames < ActiveRecord::Migration
  def change
    rename_column :courts, :best_time, :pickup_time
    rename_column :courts, :best_day, :pickup_day
    rename_column :courts, :best_time_ampm, :pickup_am
    rename_column :courts, :hours_open, :open_time_1
    rename_column :courts, :hours_open_ampm, :open_am_1
    rename_column :courts, :hours_closed, :open_time_2
    rename_column :courts, :hours_closed_ampm, :open_am_2
  end
end
