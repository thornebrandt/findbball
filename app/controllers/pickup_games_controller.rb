class PickupGamesController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @pickup_game = current_user.pickup_games.build(pickup_game_params)
        if @pickup_game.save!
            render :json => @pickup_game
        end
    end


    private
        def pickup_game_params
            params.require(:pickup_game).permit(:day, :time, :member_id, :court_id)
        end
end