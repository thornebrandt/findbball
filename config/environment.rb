# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Findbball::Application.initialize!

ENV['RAILS_ENV'] ||= 'production'

#Set default date display format
Date::DATE_FORMATS.merge!(:default => "%b %d, %Y")