class SessionsController < ApplicationController
	def new
	end

	def create
		player = Player.find_by(email: params[:session][:email].downcase)
		if player && player.authenticate(params[:session][:password]).password
		else
			flash[:error] = "Invalid email/password combination" #not right
			render 'new'
		end
	end

	def destroy
	end
end
