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
        if signed_in?
            @member = current_user
            @shown_courts = @member.courts.last(5)
            @hidden_courts = @member.courts - @shown_courts
            @shown_reviews = @member.reviews.last(5)
            @hidden_reviews = @member.reviews - @shown_reviews
        else
            redirect_to home_path
        end
    end

    def update
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
            else
                format.html { render :edit }
                format.json { respond_with_bip(@member) }
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
                                            :photo
                                        )
		end

end
