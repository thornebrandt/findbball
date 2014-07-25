class AddHeightWeightToMembers < ActiveRecord::Migration
  def change
    add_column :members, :height, :integer, :default => -1
    add_column :members, :weight, :integer, :default => -1
  end
end
