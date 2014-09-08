class SessionsController < ApplicationController
    def create
		member = Member.find_by_email(params[:email].downcase)
		if member && member.authenticate(params[:password])
            sign_in member
            redirect_back_or member
		else
			flash[:error] = "Invalid email/password combination" #not right
			redirect_to home_path
		end
	end

	def destroy
        sign_out
        redirect_to home_path
	end
end
