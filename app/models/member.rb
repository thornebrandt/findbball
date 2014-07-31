
class Member < ActiveRecord::Base
    has_many :courts
    has_many :reviews
	has_secure_password
    attr_accessor :photo_data
	before_save :beforeSave
    before_validation :beforeValidation
	before_create :create_remember_token
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, 	presence: 	true,
						format: 	{ with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
    validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true #needs to be true
    validates :birthdate, presence: true, allow_nil: false
    has_attached_file :photo,
        :styles => {:thumb => '40x40'},
        :url => "/system/member/:id/photo_:style.:extension",
        :path => ":rails_root/public/system/member/:id/photo_:style.:extension"
    validates_attachment_content_type :photo, :content_type => /\Aimage/
    do_not_validate_attachment_file_type :photo

	def beforeSave
		self.email.downcase!
		self.name ||= "New Member"
	end

    def beforeValidation
        puts self.birthdate

        #decoded_data = Base64.decode64(self.photo_data)

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