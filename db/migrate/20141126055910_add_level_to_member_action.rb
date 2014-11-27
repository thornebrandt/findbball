class AddLevelToMemberAction < ActiveRecord::Migration
    def change
        add_column :member_actions, :level, :integer, default: 0, null: false
    end
end
