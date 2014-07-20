class AddNationalityToMembers < ActiveRecord::Migration
  def change
    add_column :members, :nationality, :integer, :default => -1
  end
end
