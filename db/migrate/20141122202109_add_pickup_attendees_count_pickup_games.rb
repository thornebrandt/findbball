class AddPickupAttendeesCountPickupGames < ActiveRecord::Migration
    def change
        add_column :pickup_games, :pickup_attendees_count, :integer, default: 0, null: false
    end
end
