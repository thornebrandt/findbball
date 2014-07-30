class CourtsController < ApplicationController

  def show
    @court = Court.find(params[:id])
    @shown_reviews = @court.reviews.last(4)
    @hidden_reviews = @court.reviews - @shown_reviews
  end

  def edit
    @court = Court.find(params[:id])
    @review = @court.reviews.build
  end

  def new
    @mapEl = "add_court_map" #element of map-canvas
    @court = Court.new(params[:id])
    # @court.member_id = current_user.id
    @review = @court.reviews.new
    @review.member_id = current_user.id
    # @review = current_user.reviews.build(params[:id])
    # @review.court_id = @court.id
  end

  def create
    @court = Court.new(court_params)
    # @court.member_id = current_user.id
    # @review = @court.reviews.new(params[:review])
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
                                      :reviews,
                                      :member_id,
                                      :open_time_1,
                                      :open_am_1,
                                      :open_time_2,
                                      :open_am_2,
                                      # reviews_attributes: [:id, :content, :court, :member])
    )
    end
end