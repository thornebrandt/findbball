class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  
  def create  
    auth = request.env['omniauth.auth']
    puts auth.to_yaml
    # Find an identity here
    @identity = Identity.find_by_provider_and_uid(auth.provider, auth.uid) || Identity.create_with_omniauth(auth)
    
    if @identity.member.present?
      # The identity we found had a user associated with it so let's log them in here.
      sign_in @identity.member
      @identity.member.log("signed in")
      flash[:success] = "Signed in!"
      redirect_back_or @identity.member
    elsif Member.find_by(email: @identity.email)
      flash[:error] = "The email you have attempted to register already belongs to another user."
      redirect_to home_path
    else
      # No user associated with the identity, so we need to create a new one
      puts "creating new member"
      @identity.member = Member.create_with_omniauth(auth)
      @identity.save
      sign_in @identity.member
      @identity.member.log("signed up")
      flash[:success] = "Signed up!"
      redirect_back_or @identity.member
    end
  end


  def destroy  
    sign_out
    flash[:success] = "Signed out!"
    redirect_to home_path
  end  
  
  def failure
    flash[:error] = @identity.errors.full_messages || "Invalid email/password combination"
    redirect_to home_path
  end
end
