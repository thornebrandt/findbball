class Identity < OmniAuth::Identity::Models::ActiveRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,   presence:   true,
           format:   { with: VALID_EMAIL_REGEX },
           uniqueness: { case_sensitive: false }
  
  belongs_to :member
  
  def self.find_with_omniauth(auth)
    find_by(uid: auth.uid, provider: auth.provider)
  end

  def self.create_with_omniauth(auth)
    create(uid: auth.uid, provider: auth.provider)
  end
end