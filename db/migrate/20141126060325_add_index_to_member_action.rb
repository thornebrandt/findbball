class AddIndexToMemberAction < ActiveRecord::Migration
    def change
        add_index :member_actions, :member_id
    end
end
