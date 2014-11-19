class AddLastLoginToMembers < ActiveRecord::Migration
  def change
    add_column :members, :lastLogin, :datetime
  end
end
