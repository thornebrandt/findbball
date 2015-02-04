class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create
    auth = request.env['omniauth.auth']
    @identity = Identity.find_with_omniauth(auth)
    
    if @identity.nil?
      # If no identity was found, create a brand new one here
      @identity = Identity.create_with_omniauth(auth)
    end
    
    if signed_in?
      if @identity.user == current_user
      # User is signed in so they are trying to link an identity with their
      # account. But we found the identity and the user associated with it 
      # is the current user. So the identity is already associated with 
      # this user. So let's display an error message.
      redirect_to home_path, notice: "Already linked that account!"
      else
        # The identity is not associated with current_user so let's asssociate
        # the identity.
        @identity.user = current_user
        @identity.save()
        redirect_to home_path, notice: "Successfully linked that account!"
      end
    else
      if @identity.user.present?
        # The identity we found had a user associated with it, so
        # let's log them in here
        self.current_user = @identity.user
        redirect_to home_path, notice: "Signed in!"
      else
        # No user associated with identity, so create a new one
        redirect_to new_member_path, notice: "Please finish registering"
      end
    end
  end
    
    #member = Member.from_omniauth(env['omniauth.auth'])
    #session[:member_id] = member.id
    #redirect_to home_path, notice: "Signed in!"
      
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
        sign_out
        session[:member_id] = nil
        redirect_to home_path, notice: "Signed out!"
	end
	
	def failure
	  redirect_to home_path, alert: "Authentication failed"
	end
end
