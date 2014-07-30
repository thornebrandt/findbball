class Court < ActiveRecord::Base
  belongs_to :member
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :reviews
  
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
  
  def open_hours
    "#{self.open_time_1}:00 #{self.open_am_1.upcase} - #{self.open_time_2}:00 #{self.open_am_2.upcase}"
  end
  
  def pickup_hours
    "#{self.pickup_day}s at #{self.pickup_time}:00 #{self.pickup_am.upcase}"
  end
end
