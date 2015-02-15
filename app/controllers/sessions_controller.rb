class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    auth = env["omniauth.auth"]
    @identity = Identity.find_with_omniauth(auth)
    
    if @identity.nil?
      # If no identity was found, create a brand new one here
      @identity = Identity.create_with_omniauth(auth)
    end
  
    if signed_in?
      if @identity.member == current_user
      # User is signed in so they are trying to link an identity with their
      # account. But we found the identity and the user associated with it 
      # is the current user. So the identity is already associated with 
      # this user. So let's display an error message.
        redirect_back_or @identity.member, notice: "Already linked that account!"
      else
      # The identity is not associated with the current_user so lets 
      # associate the identity
        @identity.member = current_user
        @identity.save()
        redirect_back_or @identity.member, notice: "Successfully linked that account!"
      end
    else
      if @identity.member.present?
      # The identity we found had a user associated with it so let's 
      # just log them in here
        self.current_user = @identity.member
        sign_in member
        member.log("signed in")
        flash[:success] = "Signed in. Welcome!"
        redirect_back_or @identity.member
      else
      # No user associated with the identity so we need to create a new one
        redirect_to signup_url, notice: "Please finish registering" #TODO: It always takes this path...
      end
    end
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
	  flash[:error] = "Invalid email/password combination" # also, email already taken...
	  redirect_to home_path
	end
end
