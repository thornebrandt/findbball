class PickupAttendeesController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def index
        @pickup_attendees = PickupAttendee.find(:all)
        render :json => @pickup_attendees
    end

    def create
        @pickup_attendee = current_user.pickup_attendees.build( pickup_attendee_params )
        if @pickup_attendee.save
            render :json => @pickup_attendee
        else
            false
        end
    end

    def destroy
        @pickup_attendee = PickupAttendee.find(params[:id])
        if @pickup_attendee.destroy
            render :json => @pickup_attendee
        end
    end

    private
        def pickup_attendee_params
            params.require(:pickup_attendee).permit(:member_id, :court_id, :pickup_game_id)
        end

        def correct_user
            @pickup_attendee = current_user.pickup_attendees.find_by(id: params[:id])
            redirect_to root_url if @pickup_attendee.nil?
        end
end