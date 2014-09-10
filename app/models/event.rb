class Event < ActiveRecord::Base
  belongs_to :member, inverse_of: :events
  belongs_to :court, inverse_of: :events

  validates :name,          presence: true, length: { maximum: 150 }
  validates :court_id,      presence: true
  validates :member_id,     presence: true
  validates :start,         presence: true
  validates :end,           presence: true

end