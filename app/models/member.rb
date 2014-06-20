class Member < ActiveRecord::Base
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	has_secure_password
	before_save :beforeSave

	def beforeSave
		self.email.downcase!
		self.name ||= "New Member"
	end
end