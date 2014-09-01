class CreateCourtPhotos < ActiveRecord::Migration
  def change
    create_table :court_photos do |t|
      t.string :photo
      t.integer :court_id
      t.integer :member_id
      t.timestamps
    end
    add_index :reviews, [:court_id, :created_at]
  end
end
