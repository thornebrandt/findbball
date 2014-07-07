class ChangeUserIdToMemberId < ActiveRecord::Migration
  def change
    rename_column :courts, :user_id, :member_id
  end
end
