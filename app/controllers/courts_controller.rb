class CourtsController < ApplicationController
  
  def show
    @court = Court.find(params[:id])
    @shown_reviews = @court.reviews.last(4)
    @hidden_reviews = @court.reviews.first(@court.reviews.count - 4)
  end
  
  def edit
    @court = Court.find(params[:id])
    @review = @court.reviews.build
  end
  
  def new
    @court = Court.new(params[:id], member: current_user)
    @review = @court.reviews.build
  end
  
  def create
    @court = Court.new(court_params)
    @review = @court.reviews.build
    if @court.save
      flash[:success] = "Court created!"
      redirect_to court_path(@court)
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
                                      :member,
                                      reviews_attributes: [:id, :content, :court, :member])
    end
end