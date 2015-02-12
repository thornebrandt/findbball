class Identity < OmniAuth::Identity::Models::ActiveRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_uniqueness_of :email  
  validates_format_of :email, with: VALID_EMAIL_REGEX
end