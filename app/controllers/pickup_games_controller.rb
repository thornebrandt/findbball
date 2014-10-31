class PickupGamesController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @pickup_game = current_user.pickup_games.build( pickup_game_params )
        if @attendee.save
            flash[:success] = "You have successfully signed up for " + @event.name
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
        def pickup_game_params
            params.require(:pickup_game).permit(:day, :time, :member_id, :court_id)
        end

        def correct_user
            @attendee = current_user.attendees.find_by(id: params[:id])
            redirect_to root_url if @attendee.nil?
        end
end