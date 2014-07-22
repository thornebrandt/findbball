class Court < ActiveRecord::Base
  belongs_to :member
  has_many :reviews, dependent: :destroy
  
  validates :name,          presence: true, length: { maximum: 70 }
  validates :location,      presence: true, length: { maximum: 200 }
  validates :website,                       length: { maximum: 512 }
  validates :pickup_time,                   length: { maximum: 12 }
  validates :pickup_am,                     length: { maximum: 2 }
  validates :pickup_day,                    length: { maximum: 10 }
  validates :open_time_1,                   length: { maximum: 12 }
  validates :open_am_1,                     length: { maximum: 2 }
  validates :open_time_2,                   length: { maximum: 12 }
  validates :open_am_2,                     length: { maximum: 2 }
  validates :skill_level,                   length: { maximum: 5 }
end
