
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
    # validates :birthdate, presence: true, allow_nil: false
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

    def age
        now = Time.now.utc.to_date
        _age = now.year - birthdate.year - ((now.month > birthdate.month || ( now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1 )
        if _age < 3
            _age = "Undisclosed"
        end
        _age
    end

    def profile_photo
        if !photo_updated_at
            ActionController::Base.helpers.asset_path("player_placeholder.png")
        else
            photo.url
        end
    end

	def Member.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def Member.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

    def nationality_mapped
        case skill_level
            when -1 then "Undisclosed"
            when 1 then "Black"
            when 2 then "White"
            when 3 then "African"
            when 4 then "Latino"
            when 5 then "Hispanic"
            when 6 then "Asian"
            when 7 then "Native Amerian"
            when 8 then "Middle Eastern"
            when 9 then "Mixed"
            when 10 then "Other"
            else "Undefined"
        end
    end

    def skill_level_mapped
        case skill_level
            when -1 then "Undisclosed"
            when 1 then "Black"
            when 2 then "White"
            when 3 then "African"
            when 4 then "Latino"
            when 5 then "Hispanic"
            when 6 then "Asian"
            when 7 then "Native Amerian"
            when 8 then "Middle Eastern"
            when 9 then "Mixed"
            when 10 then "Other"
            else "Undefined"
        end
    end


	private
		def create_remember_token
			self.remember_token = Member.hash(Member.new_remember_token)
		end

end