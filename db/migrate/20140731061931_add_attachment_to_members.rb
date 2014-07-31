class AddAttachmentToMembers < ActiveRecord::Migration
  def change
    add_attachment :members, :photo
  end
end
