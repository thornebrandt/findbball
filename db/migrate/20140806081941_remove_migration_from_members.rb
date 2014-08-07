class RemoveMigrationFromMembers < ActiveRecord::Migration
  def change
    remove_attachment :members, :photo
  end
end
