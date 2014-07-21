class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
    @reviews = @court.reviews.paginate(page: params[:page])
  end

  def index
  end
  
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
        params.require(:court).permit(:name, :location, :website, :skill_level, :hours_open, :hours_open_ampm, :hours_closed_ampm,
                                      :best_day, :best_time, :best_time_ampm, :member_id)
    end
end