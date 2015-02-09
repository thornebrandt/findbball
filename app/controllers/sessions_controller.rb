class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    member = Member.from_omniauth(env["omniauth.auth"])
    session[:user_id] = member.id
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
    session[:user_id] = nil  
    redirect_to home_path, notice: "Signed out!"  
  end  
	
	def failure
	  redirect_to home_path, alert: "Invalid email/password combination"
	end
end
