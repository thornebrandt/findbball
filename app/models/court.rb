class Court < ActiveRecord::Base
  belongs_to :member
  
  validates :name,          presence: true, length: { maximum: 70 }
  validates :location,      presence: true, length: { maximum: 200 }
  validates :website,                       length: { maximum: 512 }
  validates :best_time,                     length: { maximum: 12 }
  validates :best_time_ampm,                length: { maximum: 2 }
  validates :best_day,                      length: { maximum: 10 }
  validates :hours_open,                    length: { maximum: 12 }
  validates :hours_open_ampm,               length: { maximum: 2 }
  validates :hours_closed,                  length: { maximum: 12 }
  validates :hours_closed_ampm,             length: { maximum: 2 }
  validates :skill_level,                   length: { maximum: 5 }
end
