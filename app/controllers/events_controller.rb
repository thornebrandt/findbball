class EventsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

    def show
        if Event.exists?(params[:id])
            @event = Event.find(params[:id])
            @showMap = true;
            @mapEl = "court_map"
            @court = Court.find(@event.court_id)
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
        @event = Event.find(params[:id])
        if current_user? @event.member
            gon.lat = @event.court.lat
            gon.lng = @event.court.lng
            @showMap = true
            @mapEl = "edit_court_map"
        else
            flash[:error] = "You are not that event's creator"
            redirect_to home_path
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


    def new
        puts "CALLING NEW"
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