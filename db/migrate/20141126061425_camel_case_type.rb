class CamelCaseType < ActiveRecord::Migration
    def change
        remove_column :member_actions, :link_type, :string
        add_column :member_actions, :linkType, :string
    end
end
