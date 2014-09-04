class AddMainPhotoToCourts < ActiveRecord::Migration
  def change
    add_column :courts, :main_photo, :integer
  end
end
