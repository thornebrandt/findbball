class SessionsController < ApplicationController
	def new
	end

	def create
		member = Member.find_by_email(params[:email].downcase)
		if member && member.authenticate(params[:password])
            puts "what"
            sign_in member
            redirect_back_or member
		else
			flash[:error] = "Invalid email/password combination" #not right
			render 'new'
		end
	end

	def destroy
	end
end
