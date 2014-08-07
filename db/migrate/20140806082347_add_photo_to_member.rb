class AddPhotoToMember < ActiveRecord::Migration
  def change
    add_column :members, :photo, :string
  end
end
