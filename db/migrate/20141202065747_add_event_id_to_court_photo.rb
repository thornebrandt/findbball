class AddEventIdToCourtPhoto < ActiveRecord::Migration
  def change
    add_column :court_photos, :event_id, :integer
  end
end
