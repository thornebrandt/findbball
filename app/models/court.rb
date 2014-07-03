class Court < ActiveRecord::Base
  belongs_to :member
  validates :user_id, presence: true
end
