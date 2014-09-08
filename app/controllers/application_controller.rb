class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    include SessionsHelper
    include CourtsHelper
    geocode_ip_address

    # rescue_from StandardError do |e|
    #     flash[:error] = "There was an error"
    # end

    def handle_unverified_request
        sign_out
        super
    end

end
