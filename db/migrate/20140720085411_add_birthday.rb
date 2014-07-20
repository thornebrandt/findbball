class AddBirthday < ActiveRecord::Migration
  def change
    add_column :members, :birthdate, :date
  end
end
