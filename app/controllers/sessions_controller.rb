class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    auth = request.env['omniauth.auth'].to_yaml
    puts auth
    puts auth[0]
    puts auth[1]
    # right now auth['provider'] and auth['uid'] are just returning 'provider' and 'uid' strings...
    # how to access the actual values of those keys in the yaml?
    member = Member.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Member.create_with_omniauth(auth)   
    session[:member_id] = member.id  
    redirect_to home_path, notice: "Signed in!"  
  end  
      
#   member = Member.find_by_email(params[:email].downcase)
#		if member && member.authenticate(params[:password])
#            if sign_in member
#                member.log("signed in")
#                redirect_back_or member
#            else
#                flash[:error] = "Your account has been deactivated" #not right
#                redirect_to home_path
#            end
#		else
#			flash[:error] = "Invalid email/password combination" #not right
#			redirect_to home_path
#		end

  def destroy  
    session[:member_id] = nil  
    redirect_to home_path, notice: "Signed out!"  
  end  
	
	def failure
	  redirect_to home_path, alert: "Invalid email/password combination"
	end
end
