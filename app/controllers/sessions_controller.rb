class SessionsController < ApplicationController
	def new
	end

	def create
		member = Member.find_by(email: params[:session][:email].downcase)
		if member && member.authenticate(params[:session][:password]).password
		else
			flash[:error] = "Invalid email/password combination" #not right
			render 'new'
		end
	end

	def destroy
	end
end
