class CourtsController < ApplicationController
    before_action :signed_in_user, only: [:edit, :update, :create, :new]

    def index
        @courts = Court.find(:all)
        render :json => @courts
    end

    def show
        if Court.exists?(params[:id])
            @court = Court.find(params[:id])
            @court_photo = CourtPhoto.new if signed_in?
            @review = Review.new if signed_in?
            @showMap = true
            @mapEl = "court_map"
            @shown_reviews = @court.reviews.last(4)
            @hidden_reviews = @court.reviews - @shown_reviews
            @court_photo = CourtPhoto.new if signed_in?
            @court_video = CourtVideo.new if signed_in?
            gon.court = @court
            gon.member_id = current_user.id
            gon.court_photos = @court.court_photos.last(12)
            gon.lat = @court.lat
            gon.lng = @court.lng
            @review = Review.new if signed_in?
        else
            flash[:error] = "Could not find that court"
            redirect_to home_path
            return
        end
    end

    def reload_edit_form
        @court = Court.find(params[:court_id])
        render :partial => 'courts/court_edit_form'
    end

    def reload_pickup_games
        @court = Court.find(params[:court_id])
        render :partial => 'courts/court_pickup_games'
    end


    def find_hoops
        @miles = params[:within] || 10000
        if params[:lat] && params[:lng]
            @origin = [params[:lat], params[:lng]]
        elsif params[:by]
            geo = params[:by]
        else
            geo = session[:geo_location]
            if geo.lat
                @origin = [geo.lat, geo.lng]
                gon.geo = geo;
            else
                @origin = [Rails.configuration.lat, Rails.configuration.lng]
            end
        end
        if @origin.is_a?(Array)
            gon.lat = @origin[0]
            gon.lng = @origin[1]
            @within_hoops = Court.within(@miles, :origin => @origin).limit(8)
            @found_hoops = @within_hoops.by_distance(:origin => @origin)
            gon.found_hoops = @found_hoops
        else
            @found_hoops = {}
            gon.lat = Rails.configuration.lat
            gon.lng = Rails.configuration.lng
        end
    end

    def search
        results = []
        query = params[:q]
        all = []
        if query && query != ""
            all = Court.where("name LIKE ?", "%#{query}%")
        end
        render json: all
    end

    def edit
        @court = Court.find(params[:id])
        if current_user? @court.member
            gon.lat = @court.lat
            gon.lng = @court.lng
            gon.court = @court
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
        if signed_in?
            @court = Court.new
            @court.pickup_games.build(:member_id => current_user.id)
            @review = Review.new
            @review.court_id = @court.id
            @review.member_id = current_user.id
            if geo = session[:geo_location]
                gon.geo = geo
                gon.lat = geo.lat
                gon.lng = geo.lng
            else
                gon.lat = Rails.configuration.lat
                gon.lng = Rails.configuration.lng
            end
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
                                      :open_time_1,
                                      :open_am_1,
                                      :open_time_2,
                                      :open_am_2,
                                      :open_time_1,
                                      :open_am_1,
                                      :open_time_2,
                                      :open_am_2,
                                      :main_photo,
                                      :details,
                                      :pickup_games_attributes => [ :day, :time, :member_id, :court_id]
                                      )
    end
end