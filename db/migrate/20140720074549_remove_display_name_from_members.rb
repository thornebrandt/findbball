class RemoveDisplayNameFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :display_name
  end
end
