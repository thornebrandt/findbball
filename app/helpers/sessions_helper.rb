module SessionsHelper

    def sign_in(member)
        remember_token = Member.new_remember_token
        cookies.permanent[:remember_token] = remember_token
        member.update_attributes(:remember_token => Member.hash(remember_token), :lastLogin => DateTime.now)
        member.save
        unless member.active == false
            self.current_user = member
        end
    end


    def signed_in?
        if !current_user.nil? && current_user.active
            true
        else
            false
        end
    end

    def admin?
        if !current_user.nil? && current_user.admin
            true
        else
            false
        end
    end


    def signed_in_user
      unless signed_in?
        store_location
        # Used to redirect to signin_url, but signin is now a modal
        redirect_to home_path + "?login=true", notice: "Please sign in"
      end
    end

    def admin_user
        unless admin?
            store_location
            redirect_to home_path + "?login=true", notice: "Admin account required"
        end
    end

    def current_user=(user)
        @current_user = user
    end

    def current_user
        #remember_token = Member.encrypt(cookies[:remember_token])
        #@current_user ||= Member.find_by(remember_token: remember_token)
        @current_user ||= Member.find(session[:user_id]) if session[:user_id]  
    end

    def current_user?(user)
        user == current_user
    end

    def sign_out
        cookies.delete(:remember_token)
        self.current_user = nil
    end

    def destroy
        sign_out
        redirect_to root_url
    end

    def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
    end

    def store_location
        session[:return_to] = request.url if request.get?
    end
end
