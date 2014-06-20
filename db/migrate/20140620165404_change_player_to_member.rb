class ChangePlayerToMember < ActiveRecord::Migration
  def change
	rename_table :players, :members
  end
end
