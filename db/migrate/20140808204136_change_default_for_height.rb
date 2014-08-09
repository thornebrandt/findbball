class ChangeDefaultForHeight < ActiveRecord::Migration
  def change
        change_column_default(:members, :height_feet, nil)
        change_column_default(:members, :height_inches, nil)
  end
end
