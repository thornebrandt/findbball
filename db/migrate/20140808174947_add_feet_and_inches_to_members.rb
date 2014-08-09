class AddFeetAndInchesToMembers < ActiveRecord::Migration
  def change
    add_column :members, :height_feet, :number, :default => -1
    add_column :members, :height_inches, :number, :default => -1
    remove_column :members, :height
  end
end
