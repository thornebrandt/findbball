class IdentitiesController < ApplicationController
  def new
    @noHeaderFooter = true
    @identity = env['omniauth.identity']  
    if @identity
      flash[:error] = @identity.errors.full_messages[0]
    end
  end
  
  def identity_params
      params.require(:identity).permit(     :email,
                                            :password,
                                            :password_confirmation,
                                            :password_digest,
                                            :provider,
                                            :uid,
                                            :oauth_token,
                                            :oauth_expires_at,
                                            :member_id,
                                            :name
                                        )
    end  
end