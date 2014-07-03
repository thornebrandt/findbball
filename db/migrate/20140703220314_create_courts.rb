class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :name
      t.string :address
      t.integer :user_id

      t.timestamps
    end
    # Need any indices?
  end
end
