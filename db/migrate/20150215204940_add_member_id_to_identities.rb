class AddMemberIdToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :member_id, :integer
    add_index :identities, :member_id
  end
end
