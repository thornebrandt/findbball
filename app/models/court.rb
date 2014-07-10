class Court < ActiveRecord::Base
  belongs_to :member
  
  validates :name, presence: true, length: { maximum: 70 }
  validates :address, presence: true, length: { maximum: 95 }
end
