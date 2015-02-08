class Member < ActiveRecord::Base
    has_many :courts
    has_many :court_photos
    has_many :court_videos
    has_many :court_photos, inverse_of: :member
    has_many :court_videos, inverse_of: :member
    has_many :reviews, inverse_of: :member
    has_many :events, inverse_of: :member
    has_many :attendees,  dependent: :delete_all, inverse_of: :member
    has_many :pickup_attendees, dependent: :delete_all, inverse_of: :member
    has_many :pickup_games, inverse_of: :member, dependent: :delete_all
    has_many :member_actions, inverse_of: :member, dependent: :delete_all
	  has_many :identities
	has_secure_password
	before_save :beforeSave
    before_validation :beforeValidation
	before_create :create_remember_token
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, 	presence: 	true,
						format: 	{ with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false },
						if: :fields_required?
    validates_uniqueness_of :name, :case_sensitive => false
    validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true, if: :fields_required?
    # validates :birthdate, presence: true, allow_nil: false

    mount_uploader :photo, PhotoUploader
    
  def self.from_omniauth(auth)  
    find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)  
  end  
  
  def self.create_with_omniauth(auth)  
    create! do |member|  
      member.provider = auth["provider"]  
      member.uid = auth["uid"]  
      member.name = auth["info"]["name"]
      member.email = auth['info']['email']
    end  
  end  
  
  def fields_required?
    !provider.blank? && super
  end

    def log(_text, _type = nil, _id = nil, _level = 3)
        #log level defaults to 3
        member_action = MemberAction.new
        member_action.member_id = self.id
        if defined?(_text) then member_action.action_text = _text end
        if defined?(_type) then member_action.linkType = _type end
        if defined?(_id) then member_action.link_id = _id end
        if defined?(_level) then member_action.level = _level end
        puts "LOGGING"
        if member_action.save!
            puts "SAVED"
        else
            puts "SPMETHIG WNET WRONG"
        end
    end

    def log_action(_text, _type = nil, _id = nil)
        log(_text, _type, _id, 1)
    end

    def profile_completion
        total = 0
        completed = 0
        next_action = "Complete!"
        edit_link = false;

        puts "What is happening here"

        total += 1
        if self.pickup_games.count < 1
            next_action = "Attend pickup game"
            edit_link = "find_hoops"
        else
            completed += 1
        end
        
        total += 1
        if self.courts.count < 1
          next_action = "Add a court"
          edit_link = "new_court_path"
        else
          completed += 1
        end

        total += 1
        if !self.about
            next_action = "Introduce yourself"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if !self.favorite_player
            next_action = "Add favorite player"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if self.skill_level == -1
            next_action = "Add skill level"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if self.organized == -1
            next_action = "Level of organized ball"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if self.position == -1
            next_action = "Add favorite position"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if self.plays_basketball == -1
            next_action = "How often do you play?"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if self.nationality == -1
            next_action = "Add ethnicity"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if !self.weight
            next_action = "Add weight"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if !self.height_feet
            next_action = "Add height"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if !self.birthdate
            next_action = "Add birthdate"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end


        total += 1
        if !self.full_name
            next_action = "Add full name"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if !self.general_location
            next_action = "Add general location"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if !self.photo.file
            next_action = "Upload a photo"
            edit_link = "edit_member_path(@member)"
        else
            completed += 1
        end

        total += 1
        if !self.registered
            next_action = "Verify Email."
            edit_link = false
        else
            completed += 1
        end


        percent = (((completed.to_f/total.to_f) * 100).to_i).to_s
        {percent: percent, next_action: next_action, edit_link: edit_link}
    end

    def attendingEvent(_event_id)
        Attendee.find_by_event_id_and_member_id(_event_id, self.id)
    end

    def attendingPickupGame(_pickup_game_id)
        PickupAttendee.find_by_pickup_game_id_and_member_id(_pickup_game_id, self.id)
    end

	def beforeSave
		self.email.downcase!
        unique_name_from_email( self.email )
        parameterizeUsername
	end

    def beforeValidation
        # puts self.birthdate
    end

	def Member.new_remember_token
		SecureRandom.urlsafe_base64
	end

    def member_actions
        MemberAction.where("level <=  1 AND member_id = ?", self.id).order("created_at DESC").limit(10)
    end

    def friends
        if Rails.env.production?
            Member.where('id != ?', self.id).limit(10).order("RAND()")
        else
            Member.where('id != ?', self.id).limit(10).order("RANDOM()")
        end
        #BUG maybe
        #Member.where('id != ?', self.id).limit(8).order("RANDOM()")
    end


    def parameterizeUsername
        self.name = self.name.parameterize
    end

    def unique_name_from_email(_email)
        begin
            if self.name.nil?
                self.name = self.email[/[^@]+/]
                if Member.find_by_name(self.name)
                    i = 1
                    original_name = self.name
                    loop do
                        i += 1
                        self.name = (original_name + i.to_s)
                        unique = Member.find_by_name(self.name).nil?
                        break if unique
                    end
                end
            end
        end
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

    def profile_photo_thumb
        if photo.nil?
            ActionController::Base.helpers.asset_path("player_placeholder.png")
        else
            photo.thumb
        end
    end

	def Member.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def Member.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

    def nationality_verbose
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

    def position_verbose
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

    def organized_verbose
        case organized
            when -1 then "Undisclosed"
            when 1 then "Grade School"
            when 2 then "Camp"
            when 3 then "High School"
            when 4 then "College"
            when 5 then "Professional"
            else "Undefined"
        end
    end

    def plays_basketball_verbose
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


    def skill_level_verbose
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
            height_feet.to_s + "''" + height_inches.to_s + "'"
        else
            "Undisclosed"
        end
    end

	private
		def create_remember_token
			self.remember_token = Member.hash(Member.new_remember_token)
		end
end