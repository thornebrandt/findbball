class AddVerificationToMembers < ActiveRecord::Migration
  def change
    add_column :members, :verification, :string
  end
end
