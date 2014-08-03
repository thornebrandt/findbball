class CourtsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

  def show
    @court = Court.find(params[:id])
    @shown_reviews = @court.reviews.last(4)
    @hidden_reviews = @court.reviews - @shown_reviews
    @review = @court.reviews.build
  end

  def edit
    @court = Court.find(params[:id])
    @review = @court.reviews.build
  end

  def new
    @showMap = true;
    @mapEl = "add_court_map" #element of map-canvas
    
    @court = current_user.courts.build
    @court.location = "123 Fake St, Springfield, NT"  # Until location field integrated
    
    @review = @court.reviews.build # If built on member, review doesn't show in form
    @review.member_id = current_user.id
  end

  def create
    @court = current_user.courts.build(court_params)
    if @court.save
      flash[:success] = "Court created!"
      redirect_to @court
    else
      flash[:error] = "Could not create court."
      Rails.logger.info(@court.errors.inspect) 
      render 'new'
    end
  end

    private
    def court_params
        params.require(:court).permit(:id,
                                      :name,
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
                                      :member_id,
                                      :open_time_1,
                                      :open_am_1,
                                      :open_time_2,
                                      :open_am_2,
                                      reviews_attributes: [:id, :content, :court_id, :member_id]) # "Expected court/member, got string"
    end
end