class AddMembersPersonalInfo < ActiveRecord::Migration
  def change
    add_column  :members,   :general_location,  :string
    add_column  :members,   :display_name,      :string
    add_column  :members,   :full_name,         :string
    add_column  :members,   :slogan,            :string
    add_column  :members,   :plays_basketball,  :integer,   :default => -1
    add_column  :members,   :skill_level,       :integer,   :default => -1
    add_column  :members,   :position,          :integer,   :default => -1
    add_column  :members,   :organized,         :integer,   :default => -1
    add_column  :members,   :favorite_player,   :string
    add_column  :members,   :about,             :string,    limit: 500
    add_index   :members,   :full_name
    add_index   :members,   :display_name
  end
end
