class Review < ActiveRecord::Base
  validates :member_id, presence: true
  validates :court_id, presence: true
end
