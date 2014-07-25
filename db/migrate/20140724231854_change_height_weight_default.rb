class ChangeHeightWeightDefault < ActiveRecord::Migration
  def change
    change_column_default(:members, :height, nil)
    change_column_default(:members, :weight, nil)
  end
end
