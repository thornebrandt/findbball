include ActionView::Helpers::NumberHelper

class MembersController < ApplicationController

	def show
        if Member.where(:id => params["id"]).nil?
            redirect_to home_path
        end

        if Member.where(:id => params["id"]).present?
            @member = Member.find(params["id"])
            @shown_courts = @member.courts.last(5)
            @hidden_courts = @member.courts - @shown_courts
            @shown_reviews = @member.reviews.last(5)
            @hidden_reviews = @member.reviews - @shown_reviews
        else
            flash[:error] = "Could not find that member"
            redirect_to home_path
        end
	end

	def new
		@noHeaderFooter = true
		@member = Member.new
	end

    def edit
        @member = Member.find(params[:id])
    end

    def update
        # puts "calling update"
        @member = Member.find(params[:id])

        if params[:member][:birthdate]
            new_birthdate = Chronic.parse(params[:member][:birthdate]).strftime('%Y-%m-%d');
            params[:member][:birthdate] = new_birthdate
        end

        if params[:member][:photo]
            @member.photo = base64_conversion
        end

        respond_to do |format|
            if @member.update_attributes(member_params)
                format.html { redirect_to(@member, :notice => 'User was successfully updated.') }
                format.json do
                    respond_with_bip(@member)
                end
            end
        end
    end


	def create
		if !signed_in?
            @member = Member.new(member_params)
    		if @member.save!
                sign_in @member
    			flash[:success] = "Welcome to Findbball"
    			redirect_to @member
    		else
    			@noHeaderFooter = true
    			flash[:error] = "Could not create member."
    			render 'new'
    		end
        else
            redirect_to current_user
        end
	end

	private

        def base64_conversion
            return unless @photo
            puts "BASE 64 CONVERSION"
            tempfile = new Tempfile.new['upload', 'png']
            tempfile.binmode
            tempfile.write(Base64.decode64(@photo))
            ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: 'upload.png')
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
                                            :height,
                                            :weight,
                                            :plays_basketball,
                                            :skill_level,
                                            :position,
                                            :organized,
                                            :favorite_player,
                                            :about,
                                            :photo
                                        )
		end

end
