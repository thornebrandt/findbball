class Member < ActiveRecord::Base
  has_many :courts
	has_secure_password
	before_save :beforeSave
	before_create :create_remember_token
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, 	presence: 	true,
						format: 	{ with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
    validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true

	def beforeSave
		self.email.downcase!
		self.name ||= "New Member"
	end

	def Member.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def Member.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def Member.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
		def create_remember_token
			self.remember_token = Member.hash(Member.new_remember_token)
		end
end