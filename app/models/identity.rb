class Identity < OmniAuth::Identity::Models::ActiveRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,   presence:   true,
           format:   { with: VALID_EMAIL_REGEX }
           # no uniqueness constraint - multiple identities per member could have same email
  has_secure_password validations: false, if: :password_required?
  validates_presence_of :password, if: :password_required?
  validates :password, length: {minimum: 5, maximum: 120}, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  #before_save :beforeSave
  
  belongs_to :member
  
  def password_required?
    provider.blank?
  end

  def self.create_with_omniauth(auth)
    create! do |identity|
      identity.uid = auth.uid
      identity.provider = auth.provider
      identity.email = auth.info.email
      identity.name = auth.info.name
      identity.password = identity.password_confirmation = SecureRandom.urlsafe_base64(n=6)
      if auth.provider == 'facebook'
        identity.oauth_token = auth.credentials.token
        identity.oauth_expires_at = Time.at(auth.credentials.expires_at)
      end
    end
  end
  
  #def beforeSave
   # self.email.downcase!
  #end
  
end