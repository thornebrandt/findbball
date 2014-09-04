class CourtVideo < ActiveRecord::Base
    belongs_to :member, inverse_of: :court_photos
    belongs_to :court, inverse_of: :court_photos

    default_scope -> { order('created_at DESC') }

    validates :vi, presence: true
    validates :member_id, presence: true
    validates :court_id, presence: true
end
