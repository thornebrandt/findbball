class AddInfoToCourt < ActiveRecord::Migration
  def change
    add_column  :courts,   :city,               :string
    add_column  :courts,   :state,              :string
    add_column  :courts,   :zip,                :string
    add_column  :courts,   :skill_level,        :string,    :default => -1
    add_column  :courts,   :best_time,          :string
  end
end