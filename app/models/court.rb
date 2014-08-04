class Court < ActiveRecord::Base
  belongs_to :member, inverse_of: :courts
  has_many :reviews, dependent: :destroy
  accepts_nested_attributes_for :reviews, reject_if: proc { |attributes| attributes['content'].blank? }

  VALID_URL_REGEX = /((?:https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)/i

  validates :name,          presence: true, length: { maximum: 70 }
  validates :location,      presence: true, length: { maximum: 200 }
  validates :lat,           presence: true
  validates :lng,           presence: true
  validates :member_id,     presence: true
  validates :website,                       length: { maximum: 512 }, format:   { with: VALID_URL_REGEX }
  validates :pickup_time,                   length: { maximum: 12 }
  validates :pickup_am,                     length: { maximum: 2 }
  validates :pickup_day,                    length: { maximum: 10 }
  validates :open_time_1,                   length: { maximum: 12 }
  validates :open_am_1,                     length: { maximum: 2 }
  validates :open_time_2,                   length: { maximum: 12 }
  validates :open_am_2,                     length: { maximum: 2 }
  validates :skill_level,                   length: { maximum: 5 }

  def open_hours
    "#{open_time_1}:00 #{open_am_1.upcase} - #{open_time_2}:00 #{open_am_2.upcase}"
  end

  def pickup_hours
    "#{pickup_day}s #{pickup_time}#{pickup_am.upcase}"
  end

  def format_location
    location.sub(",", ",\n")
  end

  def verbose_skill_level
    case skill_level
    when 0
        "Don't know"
    when 1
        "Beginner"
    when 2
        "Intermediate"
    when 3
        "Advanced"
    when 4
        "Difficult"
    end
  end

  def skill_image
    "icon/skill_#{verbose_skill_level.downcase}.png"
  end
end