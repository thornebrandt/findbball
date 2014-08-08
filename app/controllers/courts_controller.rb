class CourtsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

  def show
    @showMap = true;
    @mapEl = "court_map"

    @court = Court.find(params[:id])
    @shown_reviews = @court.reviews.last(4)

    @review = current_user.reviews.build if signed_in?
  end

  def show_all
    @reviews = @court.reviews.all
  end

  def edit
    @court = Court.find(params[:id])
    @review = @court.reviews.build
  end

  def new
    @showMap = true;
    @mapEl = "add_court_map"

    @court = current_user.courts.build

    @review = @court.reviews.build # If built on member, review doesn't show in form
    @review.member_id = current_user.id
  end

  def create
    @court = current_user.courts.build(court_params)
    if @court.save!
      flash[:success] = "Court created!"
      redirect_to @court
    else
      flash[:error] = "Could not create court."
      Rails.logger.info(@court.errors.inspect)
      redirect_to action: 'new'
    end
  end

  def destroy
    Court.find(params[:id]).destroy
    flash[:success] = "Court deleted."
    redirect_to home_path
  end

    private
    def court_params
        params.require(:court).permit(:id,
                                      :name,
                                      :location,
                                      :website,
                                      :lat,
                                      :lng,
                                      :member_id,
                                      :skill_level,
                                      :pickup_time,
                                      :pickup_day,
                                      :pickup_am,
                                      :open_time_1,
                                      :open_am_1,
                                      :open_time_2,
                                      :open_am_2,
                                      :open_time_1,
                                      :open_am_1,
                                      :open_time_2,
                                      :open_am_2,
                                      reviews_attributes: [:id, :content, :court_id, :member_id])
    end
end