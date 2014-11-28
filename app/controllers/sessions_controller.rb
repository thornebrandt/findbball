class SessionsController < ApplicationController
    def create
		member = Member.find_by_email(params[:email].downcase)
		if member && member.authenticate(params[:password])
            if sign_in member
                member.log("signed in")
                redirect_back_or member
            else
                flash[:error] = "Your account has been deactivated" #not right
                redirect_to home_path
            end
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
