class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    include SessionsHelper
    geocode_ip_address
    # rescue_from StandardError do |e|
    #     flash[:error] = "There was an error"
    # end

    before_filter :set_cache_buster
     def set_cache_buster
       response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
       response.headers["Pragma"] = "no-cache"
       response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
     end

    def handle_unverified_request
        sign_out
        super
    end

end
