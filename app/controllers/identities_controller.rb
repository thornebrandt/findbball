class IdentitiesController < ApplicationController
  def new  
    @noHeaderFooter = true
    @identity = env['omniauth.identity']  
  end  

end
