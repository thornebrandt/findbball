class CreateCourtVideos < ActiveRecord::Migration
  def change
    create_table :court_videos do |t|
        t.string :vi
        t.integer :court_id
        t.integer :member_id
        t.timestamps
    end
    add_index :court_videos, [:member_id, :created_at]
  end
end

