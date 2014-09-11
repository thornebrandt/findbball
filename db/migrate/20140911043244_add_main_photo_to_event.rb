class AddMainPhotoToEvent < ActiveRecord::Migration
  def change
    add_column :events, :main_photo, :integer
  end
end
