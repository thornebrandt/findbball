class Identity < OmniAuth::Identity::Models::ActiveRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,   presence:   true,
           format:   { with: VALID_EMAIL_REGEX }
           # no uniqueness constraint - multiple identities per member could have same email
  has_secure_password validations: false
  validates :password, length: {minimum: 5, maximum: 120}, on: :update, allow_blank: true, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  before_save :beforeSave
  
  belongs_to :member
  
  def password_required?
    provider.blank?
  end
  
  def self.find_with_omniauth(auth)
    find_by(uid: auth.uid, provider: auth.provider)
  end

  def self.create_with_omniauth(auth)
    create! do |identity|
      identity.uid = auth.uid
      identity.provider = auth.provider
      identity.email = auth.info.email
      puts identity.password_required? # returning false... why are validations happening? in fb and id? (password can't be blank)
      if auth.provider == 'facebook'
        identity.oauth_token = auth.credentials.token
        identity.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
    end
  end
  
  def beforeSave
    self.email.downcase!
  end
  
end