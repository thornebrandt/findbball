class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    puts env["omniauth.auth"].to_yaml
    member = Member.from_omniauth(env["omniauth.auth"])
    sign_in member
    #session[:user_id] = member.id
    member.log("signed in")
    flash[:success] = "Signed in. Welcome!"
    redirect_back_or member
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
    #session[:user_id] = nil  
    sign_out
    redirect_to home_path, notice: "Signed out!"  
  end  
	
	def failure
	  flash[:error] = "Invalid email/password combination"
	  redirect_to home_path
	end
end
