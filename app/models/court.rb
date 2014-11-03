class Court < ActiveRecord::Base
  belongs_to :member, inverse_of: :courts
  has_many :reviews, dependent: :destroy, inverse_of: :court
  has_many :events, dependent: :destroy, inverse_of: :court
  has_many :court_photos, dependent: :destroy, inverse_of: :court
  has_many :court_videos, dependent: :destroy, inverse_of: :court
  has_many :attendees, inverse_of: :court
  has_many :pickup_games, inverse_of: :court, dependent: :destroy

  accepts_nested_attributes_for :pickup_games, reject_if: proc { |attributes| attributes[:day].blank? }
  accepts_nested_attributes_for :reviews, reject_if: proc { |attributes| attributes['content'].blank? }
  accepts_nested_attributes_for :events
  accepts_nested_attributes_for :court_photos
  accepts_nested_attributes_for :court_videos

  acts_as_mappable :default_units => :miles,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  # VALID_URL_REGEX = /((?:https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)/i

  validates :name,          presence: true, length: { maximum: 70 }
  validates :location,      presence: true, length: { maximum: 200 }
  validates :lat,           presence: true
  validates :lng,           presence: true
  validates :member_id,     presence: true
  validates :open_time_1,                   length: { maximum: 12 }
  validates :open_am_1,                     length: { maximum: 2 }
  validates :open_time_2,                   length: { maximum: 12 }
  validates :open_am_2,                     length: { maximum: 2 }
  validates :skill_level,                   length: { maximum: 5 }

  def open_hours
    if open_am_1
        "Open #{open_time_1}:00 #{open_am_1.upcase} - #{open_time_2}:00 #{open_am_2.upcase}"
    else
        ""
    end
  end


  def short_added_date
    created_at.strftime("%-m/%e")
  end

  def format_location
    location.sub(",", ",\n")
  end

  def verbose_skill_level
    case skill_level
      when -1 then "Undsiclosed"
      when  0 then "Don't know"
      when  1 then "Beginner"
      when  2 then "Intermediate"
      when  3 then "Advanced"
      when  4 then "Difficult"
    end
  end

  def mainPhoto
      if self.main_photo
          img_path = CourtPhoto.find(self.main_photo).photo
      elsif self.court_photos.any?
          img_path = self.court_photos.first().photo
      else
          img_path = ActionController::Base.helpers.asset_path("courts/default.jpg")
      end
      img_path
  end


  def skill_image
    if skill_level > 0
        ActionController::Base.helpers.asset_path("icon/skill_#{verbose_skill_level.downcase}.png")
    end
  end

end