class CourtsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

  def show
    if Court.exists?(params[:id])
        @court = Court.find(params[:id])
        @court_photo = CourtPhoto.new if signed_in?
        @review = Review.new if signed_in?
        @showMap = true;
        @mapEl = "court_map"

        @shown_reviews = @court.reviews.last(4)
        @hidden_reviews = @court.reviews - @shown_reviews
        @court_photo = CourtPhoto.new if signed_in?
        @review = Review.new if signed_in?
    else
        flash[:error] = "Could not find that court"
        redirect_to home_path
        return
    end
  end

  def edit
    @court = Court.find(params[:id])
    if current_user? @court.member
      @showMap = true;
      @mapEl = "edit_court_map"
      @review = Review.new
    else
      flash[:error] = "You are not that court's owner"
      redirect_to home_path
    end
  end

  def update
    @court = Court.find(params[:id])
        respond_to do |format|
            if @court.update_attributes(court_params)
                format.html { redirect_to(@court, notice: 'Court was successfully updated.') }
                format.json do
                    respond_with_bip(@court)
                end
            else
                format.html { render :edit }
                format.json { respond_with_bip(@court) }
            end
        end
    end

  def new
    @showMap = true;
    @mapEl = "add_court_map"
    if current_user
        @court = Court.new

        @review = Review.new
        @review.court_id = @court.id
        @review.member_id = current_user.id
    else
        flash[:warning] = "You are not logged in."
        redirect_to home_path
    end
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