class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
    @shown_reviews = @court.reviews.last(4)
    @hidden_reviews = @court.reviews.first(@court.reviews.count - 4)
  end
  
  def edit
    @court = Court.find(params[:id])
  end
  
  def new
    # Wait until current_user sessions stuff works to use this.
    # @court = current_user.courts.build(court_params)
    @court = Court.new(court_params)
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
                                      :member)
    end
end