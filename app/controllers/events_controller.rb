class EventsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :create, :new]

    def show
    if Event.exists?(params[:id])
    else
        flash[:error] = "Could not find that event."
        redirect_to home_path
        return
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
                                        :details )
        end


end