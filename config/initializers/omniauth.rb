OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "834139399961538", "aa3e8798e83f3da891c1b589a427b7a7", display: :popup
  #provider :identity, on_failed_registration: lambda { |env|      
  #  IdentitiesController.action(:new).call(env)  
  #}  
end