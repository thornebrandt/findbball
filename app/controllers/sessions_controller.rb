class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    auth = request.env['omniauth.auth']
    puts auth.to_yaml
    # Find an identity here
    @identity = Identity.find_by_provider_and_uid(auth.provider, auth.uid)

    if @identity.nil?
      puts "no identity found for", auth.provider, auth.uid, "creating new one"
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
      # The identity is not associated with the current_user so let's 
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
    elsif Member.find_by(email: @identity.email)
      # TODO: Dangerous. This can be used to access someone else's account if you sign up with their email.
      # This can't be the way to do it.
      @identity.member = Member.find_by(email: @identity.email)
      @identity.save
      sign_in @identity.member
      flash[:success] = "Signed in! You may now sign into this account either through Facebook or your email/password."
      redirect_back_or @identity.member
    else
      # No user associated with the identity so we need to create a new one
      puts "creating new member"
      @identity.member = Member.create_with_omniauth(auth)
      @identity.save
      sign_in @identity.member
      @identity.member.log("signed up")
      flash[:success] = "Signed up!"
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
