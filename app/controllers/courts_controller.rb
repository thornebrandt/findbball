class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
    @court_reviews = @court.reviews
  end
  
  def edit
    @court = Court.find(params[:id])
  end
  
  def new
    @court = current_user.courts.build(court_params)
    @review = @court.reviews.build
  end
  
  def create
    @court = Court.new(court_params)
    @review = Review.create(params[:reviews])
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
        params.require(:court).permit(:name, 
                                      :location, 
                                      :website, 
                                      :skill_level, 
                                      :pickup_time, 
                                      :pickup_day, 
                                      :pickup_am,
                                      :open_time_1, 
                                      :open_am_1, 
                                      :open_time_2, 
                                      :open_am_2, 
                                      :reviews, 
                                      :member_id)
    end
end