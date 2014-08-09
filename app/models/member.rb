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
    # validates :birthdate, presence: true, allow_nil: false

    mount_uploader :photo, PhotoUploader

	def beforeSave
		self.email.downcase!
		self.name ||= "New Member"
	end

    def beforeValidation
        # puts self.birthdate
    end

	def Member.new_remember_token
		SecureRandom.urlsafe_base64
	end

    def age
        now = Time.now.utc.to_date
        if birthdate
            _age = now.year - birthdate.year -
            ((now.month > birthdate.month || ( now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1 )
            if _age < 3
                _age = "Undisclosed"
            end
            _age
        else
            "Undisclosed"
        end
    end

    def profile_photo
        if photo.nil?
            ActionController::Base.helpers.asset_path("player_placeholder.png")
        else
            photo
        end
    end

	def Member.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def Member.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

    def nationality_mapped
        case nationality
            when -1 then "Undisclosed"
            when 1 then "Black"
            when 2 then "White"
            when 3 then "African"
            when 4 then "Latino"
            when 5 then "Hispanic"
            when 6 then "Asian"
            when 7 then "Native American"
            when 8 then "Middle Eastern"
            when 9 then "Mixed"
            when 10 then "Other"
            else "Undefined"
        end
    end

    def position_mapped
        case position
            when -1 then "Undisclosed"
            when 1 then "Point guard"
            when 2 then "Shooting guard"
            when 3 then "Small forward"
            when 4 then "Power forward"
            when 5 then "Center"
            when 6 then "Offense"
            when 7 then "Defense"
            when 8 then "Offensive"
            when 9 then "Quarterback"
            when 10 then "Other"
            when 11 then "Don't care"
            else "Undefined"
        end
    end

    def organized_mapped
        case organized
            when -1 then "Undisclosed"
            when 1 then "Grade School"
            when 2 then "Camp"
            when 3 then "High School"
            when 4 then "College"
            when 5 then "Proffessional"
            else "Undefined"
        end
    end

    def plays_basketball_mapped
        case plays_basketball
            when -1 then "Undisclosed"
            when 1 then "Any given second"
            when 2 then "Every day"
            when 3 then "A few times a week"
            when 4 then "Once a week"
            when 5 then "A few times a month"
            when 6 then "Once a month"
            when 7 then "A few times a year"
            when 8 then "Hardly ever"
            when 9 then "I've never played"
            else "Undefined"
        end
    end


    def skill_level_mapped
        case skill_level
            when -1 then "Undisclosed"
            when 1 then "Never Played"
            when 2 then "Beginner"
            when 3 then "Intermediate"
            when 4 then "Advanced"
            when 5 then "Baller"
            else "Undefined"
        end
    end

    def height
        if height_feet
            height_feet.to_s + ", dude"
        else
            "Undisclosed"
        end
    end


	private
		def create_remember_token
			self.remember_token = Member.hash(Member.new_remember_token)
		end
end