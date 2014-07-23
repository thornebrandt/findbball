class Member < ActiveRecord::Base
  has_many :courts
  has_many :reviews
	has_secure_password
	before_save :beforeSave
    before_validation :beforeValidation
	before_create :create_remember_token
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, 	presence: 	true,
						format: 	{ with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
    validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true #needs to be true
    validates :birthdate, presence: true, allow_nil: false

	def beforeSave
		self.email.downcase!
		self.name ||= "New Member"
	end

    def beforeValidation
        puts "this is what is coming in"
        puts self.birthdate
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

    # def valiDate(date_string)
    #     if Chronic.parse(date_string).nil?
    #         errors.add :
    # end

	private
		def create_remember_token
			self.remember_token = Member.hash(Member.new_remember_token)
		end
end