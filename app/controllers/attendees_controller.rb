class AttendeesController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @attendee = current_user.attendees.build( attendee_params )
        @event = @attendee.event
        if @attendee.save
            flash[:success] = "You have successfully signed up for " + @event.name
            cuurent_user.log_action("Signed up for ", "event", @event.id)
            redirect_to @attendee.event
        else
            flash[:error] = "Could not sign up for " + @event.name
            redirect_to @attendee.event
        end
    end

    def destroy
        @attendee = Attendee.find(params[:id])
        @event = @attendee.event
        @attendee.destroy
        flash[:info] = "You are no longer signed up for " + @event.name
        redirect_to @event
    end

    private
        def attendee_params
            params.require(:attendee).permit(:member_id, :court_id, :event_id)
        end

        def correct_user
            @attendee = current_user.attendees.find_by(id: params[:id])
            redirect_to root_url if @attendee.nil?
        end
end