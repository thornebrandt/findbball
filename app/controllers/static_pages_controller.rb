class StaticPagesController < ApplicationController
    def home
    	@hero = true
    end

    def splash
    	@noHeaderFooter = true
    end

    def verify_email
        #localhost:3000/verify_email?i=13&q=60d39f4b37803e2c569829bb64
        @member = Member.find(params[:i])
        if @member
            @email_verification = params[:q]
            if @email_verification == @member.verification.to_s
                flash[:notice] = "Thank you for registering your email, #{@member.name}!"
                if signed_in?
                    if current_user == @member
                        redirect_to @member
                    else
                        sign_out
                        sign_in @member
                        redirect_to @member
                    end
                else
                    sign_in @member
                    redirect_to @member
                end
            else
                flash[:error] = "Invalid email verification."
                if @signed_in
                    redirect_to current_user
                else
                    redirect_to home_path
                end
            end
        else
            flash[:error] = "Invalid email verification."
            redirect_to home_path
        end
    end

end
