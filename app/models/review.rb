class Review < ActiveRecord::Base
  belongs_to :member, inverse_of: :reviews
  belongs_to :court, inverse_of: :reviews
  
  default_scope -> { order('created_at DESC') }
  
  validates :content, presence: true, length: { maximum: 1000 }
  validates :member, presence: true
  validates :court, presence: true
end
