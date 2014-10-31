class PickupGame < ActiveRecord::Base
    belongs_to :court, inverse_of: :pickup_games
    belongs_to :member, inverse_of: :pickup_games


validates   :day,       presence: true
validates   :time,      presence: true
validates   :member_id, presence: true
validates   :member,    presence: true
end
