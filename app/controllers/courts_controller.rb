class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
  end
  
  def new
    @court = Court.new
  end
  
  def create
    @court = Court.new(court_params)
    if @court.save
      flash[:success] = "Court created!"
      redirect_to @court
    else
      flash[:error] = "Could not create court."
      render 'new'
    end
  end
  
    private
    def court_params
        params.require(:court).permit(:name, :address, :member_id)
    end
end