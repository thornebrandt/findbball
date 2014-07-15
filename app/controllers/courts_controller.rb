class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
  end

  def index
  end
  
  before_action :signed_in_user
  
  def edit
  end
  
  def new
    @court = current_user.courts.build(court_params)
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
        params.require(:court).permit(:name, :address, :city, :state, :member_id)
    end
end