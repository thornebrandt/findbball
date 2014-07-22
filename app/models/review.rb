class Review < ActiveRecord::Base
  belongs_to :member
  belongs_to :court
  
  default_scope -> { order('created_at DESC') }
  
  validates :content, presence: true, length: { maximum: 1000 }
  validates :member_id, presence: true
  validates :court_id, presence: true
end
