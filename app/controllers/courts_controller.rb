class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
  end
  
  def new
    @court = current_user.courts.build if signed_in?
  end
  
  def create
    @court = Court.new(court_params)
    if @court.save
      flash[:success] = "Court created!"
      redirect_to @court
    else
      @noHeaderFooter = true
      flash[:error] = "Could not create court."
      render 'new'
    end
  end
end
