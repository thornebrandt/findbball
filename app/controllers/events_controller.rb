class EventsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

    def show
        if Event.exists?(params[:id])
            @event = Event.find(params[:id])
            @showMap = true;
            @mapEl = "court_map"
            @court = Court.find(@event.court_id)
            @attendee = Attendee.new if signed_in?
            @court_photo = CourtPhoto.new if signed_in?
            gon.court_photos = @court.court_photos.last(12);
            gon.lat = @event.court.lat
            gon.lng = @event.court.lng
        else
            flash[:error] = "Could not find that event."
            redirect_to home_path
            return
        end
    end


    def create
        @event = current_user.events.build(event_params)
        @court = Court.find(params[:event][:court_id])
        @event.lat = @court.lat
        @event.lng = @court.lng
        #temporary solution until we can map through
        if @event.save!
            flash[:success] = "Event created!"
            redirect_to @event
        else
            flash[:error] = "Could not create event."
            Rails.logger.info(@event.errors.inspect)
            redirect_to action: 'new'
        end
    end

    def edit
        if Event.exists?(params[:id])
            @event = Event.find(params[:id])
            gon.editEvent = @event
            if current_user? @event.member
                #temporary solution until we can map through
                @event.lat = @event.court.lat
                @event.lng = @event.court.lng
                gon.lat = @event.court.lat
                gon.lng = @event.court.lng
                @showMap = true
                @mapEl = "edit_court_map"
            else
                flash[:error] = "You are not that event's creator"
                redirect_to home_path
            end
        else
            flash[:error] = "Could not find that event."
            redirect_to home_path
            return
        end
    end

    def update
        @event = Event.find(params[:id])
        respond_to do |format|
            if @event.update_attributes(event_params)
                format.html { redirect_to(@event, notice: "Event was successfully updated.") }
                format.json do
                    respond_with_bip(@event)
                end
            else
                format.html { render :edit }
                format.json { respond_with_bip(@event) }
            end
        end
    end

    def find_events
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
            within_events = Event.within(@miles, :origin => @origin).limit(8)
            @found_events = within_events.by_distance(:origin => @origin)
        else
            @found_events = {}
            gon.lat = Rails.configuration.lat
            gon.lng = Rails.configuration.lng
        end
    end


    def new
        @showMap = true;
        @mapEl = "add_event_map"
        if signed_in?
            @event = Event.new
        else
            flash[:warning] = "You are not logged in."
            redirect_to home_path
        end
    end

    private
        def event_params
        params.require(:event).permit(  :name,
                                        :court_id,
                                        :member_id,
                                        :start,
                                        :end,
                                        :details,
                                        :main_photo
                                         )
        end


end