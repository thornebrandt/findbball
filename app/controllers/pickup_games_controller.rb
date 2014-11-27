class PickupGamesController < ApplicationController
    before_action :signed_in_user, only: [:edit, :update, :create, :destroy]

    def index
        @pickup_games = PickupGame.find(:all)
        render :json => @pickup_games
    end

    def show
        @pickup_game = PickupGame.find(params[:id])
        render :json => @pickup_game
    end

    def create
        @pickup_game = current_user.pickup_games.build(pickup_game_params)
        if @pickup_game.save!
            #also create a pickup_attendee
            @pickup_attendee = PickupAttendee.new
            @pickup_attendee.pickup_game_id = @pickup_game.id
            @pickup_attendee.court_id = @pickup_game.court_id
            @pickup_attendee.member_id = @pickup_game.member_id
            if @pickup_attendee.save!
                current_user.log_action('created a pickup game at ', 'pickup game', @pickup_attendee.court_id)
                render :json => @pickup_game
            end
        end
    end

    def update
        @pickup_game = PickupGame.find(params[:id])
        if @pickup_game.update_attributes(pickup_game_params)
            render :json => @pickup_game
        end
    end

    def destroy
        @pickup_game = PickupGame.find(params[:id])
        @court = @pickup_game.court
        if @pickup_game.destroy
            render :json => @pickup_game
        end
    end

    def court_pickup_games
        @court = Court.find(params[:court_id])
        @pickup_games = @court.pickup_games
        render :json => @pickup_games
    end

    private
        def pickup_game_params
            params.require(:pickup_game).permit(:day, :time, :member_id, :court_id)
        end

        def correct_user
            @pickup_game = PickupGame.find(params[:id])
            @court = Court.find(@pickup_game.court_id)
            if(@court.member_id != current_user.id && @pickup_game.member_id != current_user.id)
                flash[:info] = "That pickup game didn't belong to you"
                redirect_to root_url
            end
        end

end