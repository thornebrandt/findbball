class PickupAttendee < ActiveRecord::Base
    belongs_to :pickup_game, inverse_of: :pickup_attendees, :counter_cache => :pickup_attendees_count
    belongs_to :member, inverse_of: :pickup_attendees
    belongs_to :court, inverse_of: :pickup_attendees

    validates :pickup_game_id, presence: true
    validates :member_id, presence: true
    validates_uniqueness_of :member_id, :scope => :pickup_game_id
end