# Load the Rails application.
require File.expand_path('../application', __FILE__)

#load the app's custom environment variables here:
app_env_vars = File.join(Rails.root, 'config', 'initializers', 'app_env_vars.rb')
load(app_env_vars) if File.exists?(app_env_vars)

# Initialize the Rails application.
Findbball::Application.initialize!

ENV['RAILS_ENV'] ||= 'production'

#Set default date display format
Date::DATE_FORMATS.merge!(:default => "%b %d, %Y")