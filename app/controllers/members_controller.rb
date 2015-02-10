include ActionView::Helpers::NumberHelper

class MembersController < ApplicationController

    def index
        @members = Member.find(:all)
        render :json => @members
    end

    def search
        results = []
        query = params[:q]
        all = []
        if query && query != ""
            all = Member.where("name LIKE ?", "%#{query}%")
        end
        render json: all
    end

    def profile
        redirect_to current_user
    end


	def show
        if Member.exists?(params[:id])
            @member = Member.find(params[:id])
        elsif Member.exists?(:name=> params[:id])
            @member = Member.find_by_name(params[:id])
        else
            flash[:error] = "Could not find that member"
            redirect_to home_path
            return
        end
        @shown_courts = @member.courts.last(5)
        @hidden_courts = @member.courts - @shown_courts
        @shown_reviews = @member.reviews.last(5)
        @hidden_reviews = @member.reviews - @shown_reviews
        #or statement in query, very nice...
        @pickup_games = PickupGame.where(:member_id => @member.id) |
            PickupGame.includes(:pickup_attendees).where("pickup_attendees.member_id = ?", @member.id).references(:pickup_attendees)

        @pickup_games = @pickup_games.sort_by(&:pickup_attendees_count).reverse()
        gon.member_id = @member.id
        gon.current_member_id = current_user.id if signed_in?
    end

    def destroy
        @user = User.find(params[:id])
        if @user == current_user
            @user.destroy
            flash[:success] = "User deleted"
            redirect_to home_path
            current_user = nil
        end
    end

	def new
	  puts "members#new got called"
		@noHeaderFooter = true
		@member = Member.new
	end

    def edit
        if signed_in?
            @member = current_user
            @shown_courts = @member.courts.last(5)
            @hidden_courts = @member.courts - @shown_courts
            @shown_reviews = @member.reviews.last(5)
            @hidden_reviews = @member.reviews - @shown_reviews
            @pickup_games = PickupGame.where(:member_id => @member.id) |
                PickupGame.includes(:pickup_attendees).where("pickup_attendees.member_id = ?", @member.id).references(:pickup_attendees)

            @pickup_games = @pickup_games.sort_by(&:pickup_attendees_count).reverse()
        else
            redirect_to home_path
        end
    end

    def update
        puts "members#update got called"
        @member = Member.find(params[:id])

        if params[:member][:birthdate]
            new_birthdate = Chronic.parse(params[:member][:birthdate]).strftime('%Y-%m-%d');
            params[:member][:birthdate] = new_birthdate
        end

        if params[:member][:photo]
            @member.photo = base64_conversion
            @member.log('changed their photo')
        end

        respond_to do |format|
            if @member.update_attributes(member_params)
                format.html { redirect_to(@member, :notice => 'Your profile was updated successfully!') }
                format.json do
                    flash[:notice] = "Your profile was updated successfully!"
                    respond_with_bip(@member)
                end
                @member.log('edited their profile')
            else
                format.html { render :edit }
                format.json { respond_with_bip(@member) }
            end
        end
    end


	def create
	  puts "members#create got called"
		if !signed_in?
		        puts "member being created"
            @member = Member.new(member_params)
            @member.verification = SecureRandom.hex(13)
            if geo = session[:geo_location]
                @member.lat = geo.lat
                @member.lng = geo.lng
            end
    		begin
                if @member.save!
                    MemberMailer.verify_email(@member).deliver
                    sign_in @member
        			flash[:success] = "Welcome to Findbball"
                    @member.log_action("signed up");
        			redirect_to @member
        		else
                    flash[:error] = "Could not create member."
        			@noHeaderFooter = true
        			render 'new'
        		end
            rescue => e
                flash[:error] = "Sorry, #{@member.email} is already in use"
                redirect_to signup_path
            end
        else
            redirect_to current_user
        end
	end


    def verify_email
        @member = Member.find(params[:i])
        if @member
            @email_verification = params[:q]
            if @email_verification == @member.verification.to_s
                if @member.update(registered: true)
                    flash[:notice] = "Thank you for registering your email, #{@member.name}!"
                    if signed_in?
                        if current_user == @member
                            @member.log("Verified email.");
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

    def reload_pickup_games
        @member = Member.find(params[:member_id])
        @pickup_games = PickupGame.includes(:pickup_attendees).where("pickup_attendees.member_id = ?", params[:member_id]).references(:pickup_attendees) |
                        PickupGame.where(:member_id => params[:member_id])
        @pickup_games = @pickup_games.sort_by(&:pickup_attendees_count).reverse()
        render :partial => 'members/member_pickup_games'
    end

	private

        def split_base64(uri_str)
            if uri_str.match(%r{^data:(.*?);(.*?),(.*)$})
                uri = Hash.new
                uri[:type] = $1 # "image/gif"
                uri[:encoder] = $2 # "base64"
                uri[:data] = $3 # data string
                uri[:extension] = $1.split('/')[1] # "gif"
                return uri
            else
                return nil
            end
        end

        def sanitize_filename(filename)
            #TODO: implement this
          filename.gsub(/[^0-9A-z.\-]/, '_')
        end

        def base64_conversion
            if params[:member][:photo].try(:match, %r{^data:(.*?);(.*?),(.*)$})
                image_data = split_base64( params[:member][:photo] )
                image_data_string = image_data[:data]
                image_data_binary = Base64.decode64(image_data_string)

                temp_img_file = Tempfile.new("data_uri-upload")
                temp_img_file.binmode
                temp_img_file << image_data_binary
                temp_img_file.rewind

                img_params = {:filename => "member#{@member.id}.#{image_data[:extension]}",
                            :type => image_data[:type], :tempfile => temp_img_file}
                uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)
                params[:member][:photo] = uploaded_file
            end
            # return obj_hash
        end




		def member_params
			params.require(:member).permit( :name,
                                            :email,
                                            :password,
                                            :password_confirmation,
                                            :full_name,
                                            :general_location,
                                            :nationality,
                                            :birthdate,
                                            :courts,
                                            :slogan,
                                            :height_feet,
                                            :height_inches,
                                            :weight,
                                            :plays_basketball,
                                            :skill_level,
                                            :position,
                                            :organized,
                                            :favorite_player,
                                            :about,
                                            :photo,
                                            :registerd,
                                            :verification,
                                            :lastLogin,
                                            :provider,
                                            :uid,
                                            :oauth_token,
                                            :oauth_expires_at
                                        )
		end

end
