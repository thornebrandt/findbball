class Court < ActiveRecord::Base
  belongs_to :member
  
  validates :name, presence: true, length: { maximum: 70 }
  validates :address, presence: true, length: { maximum: 95 }
  validates :city, presence: true, length: { maximum: 45 }
  validates :state, length: { maximum: 45 }
  validates :zip, length: { maximum: 11 }
  validates :country, presence: true, length: { maximum: 70 }
end
