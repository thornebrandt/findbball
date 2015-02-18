class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    auth = request.env['omniauth.auth']
    puts auth.to_yaml
    # Find an identity here
    @identity = Identity.find_by_provider_and_uid(auth.provider, auth.uid) || Identity.create_with_omniauth(auth)

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
      # If there's already a member with that email, then that member account either already belongs to the user,
      # or the user is trying to get access to someone else's account...
      if auth.provider == 'facebook'
        # TODO: Make sure email is verified
        @identity.member = Member.find_by(email: @identity.email)
        @identity.save
        sign_in @identity.member
        flash[:success] = "Signed in! You may now sign into this account either through Facebook or your email/password."
        redirect_back_or @identity.member
      end
      flash[:error] = "The email you have attempted to register belongs to another user."
      redirect_to home_path
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

  def destroy  
    sign_out
    flash[:success] = "Signed out!"
    redirect_to home_path
  end  
  
  def failure
    flash[:error] = "Invalid email/password combination"
    redirect_to home_path
  end
end
