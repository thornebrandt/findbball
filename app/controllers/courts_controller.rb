class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
  end
  
  def new
    @court = current_user.courts.build if signed_in?
  end
  
end
