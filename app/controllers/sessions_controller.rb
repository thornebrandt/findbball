class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    auth = request.env['omniauth.auth']
    puts auth.to_yaml
    # Find an identity here
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
        flash[:error] = "Already linked that account!"
        redirect_back_or @identity.member
      else
      # The identity is not associated with the current_user so lets 
      # associate the identity
        @identity.member = current_user
        @identity.save
        flash[:success] = "Successfully linked that account!"
        redirect_back_or @identity.member
    end
  else
    if @identity.member.present?
      # The identity we found had a user associated with it so let's 
      # just log them in here
      sign_in @identity.member
      @identity.member.log("signed in")
      flash[:success] = "Signed in!"
      redirect_back_or @identity.member
    else
      # No user associated with the identity so we need to create a new one
      @identity.member = Member.from_omniauth(auth)
      sign_in @identity.member
      @identity.member.log("signed in")
      flash[:success] = "Signed in!"
      redirect_back_or @identity.member
    end
  end
end
      
#   member = Member.find_by_email(params[:email].downcase)
#   if member && member.authenticate(params[:password])
#            if sign_in member
#                member.log("signed in")
#                redirect_back_or member
#            else
#                flash[:error] = "Your account has been deactivated" #not right
#                redirect_to home_path
#            end
#   else
#     flash[:error] = "Invalid email/password combination" #not right
#     redirect_to home_path
#   end

  def destroy  
    #session[:user_id] = nil  
    sign_out
    flash[:success] = "Signed out!"
    redirect_to home_path
  end  
  
  def failure
    flash[:error] = "Invalid email/password combination"
    redirect_to home_path
  end
end
