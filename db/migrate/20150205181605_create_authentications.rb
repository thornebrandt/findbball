class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.integer :member_id
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
