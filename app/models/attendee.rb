class Attendee < ActiveRecord::Base
    belongs_to :event, inverse_of: :attendees
    belongs_to :member, inverse_of: :attendees
    belongs_to :court, inverse_of: :attendees

    validates :event_id, presence: true
    validates :member_id, presence: true

end