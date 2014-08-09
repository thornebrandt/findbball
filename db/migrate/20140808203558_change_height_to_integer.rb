class ChangeHeightToInteger < ActiveRecord::Migration
  def change
    change_column :members, :height_feet, :integer
    change_column :members, :height_inches, :integer
  end
end
