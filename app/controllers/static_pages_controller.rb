class StaticPagesController < ApplicationController
  def home
  end

  def splash
  	@noHeaderFooter = true
  end

end
