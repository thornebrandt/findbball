class EventsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

    def show
        if Event.exists?(params[:id])
            @event = Event.find(params[:id])
            @showMap = true;
            @mapEl = "court_map"
            @court = Court.find(@event.court_id)
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