OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "834139399961538", "aa3e8798e83f3da891c1b589a427b7a7", display: :popup, 
           client_options: { ssl:{ ca_file: "#{Rails.root}/config/ca-bundle.crt" } }
  provider :identity, on_failed_registration: lambda { |env|      
    IdentitiesController.action(:new).call(env)  
  }  
end