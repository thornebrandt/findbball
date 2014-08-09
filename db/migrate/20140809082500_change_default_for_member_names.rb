class ChangeDefaultForMemberNames < ActiveRecord::Migration
  def change
    change_column_default(:members, :name, nil)
  end
end
