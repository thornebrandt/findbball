class PickupGamesController < ApplicationController
    before_action :signed_in_user, only: [:edit, :update, :create, :destroy]
    before_action :correct_user, only: :destroy

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
            render :json => @pickup_game
        end
    end

    def update
        @pickup_game = PickupGame.find(params[:id])
        puts "PICKUP GAME!!"
        puts params[:pickup_game]
        if @pickup_game.update_attributes({ time: 11.0 })
            render :json => @pickup_game
        else
            p "ERROWEROWEROWEROWEROWER"
            p current_user.errors.inspect
        end
    end

    # def update
    #    @resource = Resource.find(params[:id])

    #    respond_to do |format|
    #      if @resource.update_attributes(params[:resource])
    #        format.html { redirect_to @resource, notice: 'successfully updated.' }
    #        format.js
    #      else
    #        format.html { render action: "edit" }
    #        format.js
    #      end
    #    end
    #  end


    private
        def pickup_game_params
            params.require(:pickup_game).permit(:day, :time, :member_id, :court_id)
        end
end