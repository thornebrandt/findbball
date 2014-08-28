class CourtsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

  def show
    # TODO: better error handling for nonexistent court (currently default rails 404)
    @showMap = true;
    @mapEl = "court_map"

    @court = Court.find(params[:id])
    @shown_reviews = @court.reviews.last(4)
    @hidden_reviews = @court.reviews - @shown_reviews

    # @review = current_user.reviews.build if signed_in?
    @review = Review.new if signed_in?
  end

  def edit
    @showMap = true;
    @mapEl = "edit_court_map"
    @court = Court.find(params[:id])
    @review = Review.new
  end

  def update
    @court = Court.find(params[:id])

        respond_to do |format|
            if @court.update_attributes(court_params)
                format.html { redirect_to(@court, :notice => 'Court was successfully updated.') }
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
        @review = @court.reviews.build # If built on member, review doesn't show in form
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