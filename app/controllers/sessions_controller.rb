class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    auth = request.env['omniauth.auth']
    # Find an identity here
    @identity = Identity.find_by_provider_and_uid(auth.provider, auth.uid) || Identity.create_with_omniauth(auth)
      if @identity.member.present? && @identity.provider == 'facebook'
        # The identity we found had a fb user associated with it so let's log them in here.
        sign_in @identity.member
        @identity.member.log("signed in")
        flash[:success] = "Signed in!"
        redirect_back_or @identity.member
      elsif @member = Member.find_by(email: @identity.email)
        flash[:success] = "#{@identity.email} signed in!"
        sign_in @member
        @member.log("signed_in")
        redirect_back_or @member
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
    flash[:error] = "Invalid email/password combination"
    redirect_to home_path
  end
end
