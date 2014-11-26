class CourtPhotosController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @court_photo = current_user.court_photos.build( court_photo_params )

        if params[:court_photo][:photo]
            @court_photo.photo = base64_conversion
        end

        if @court_photo.save
            flash[:success] = "Court photo uploaded"
            if params[:court_photo][:event_id]
                @event = Event.find(params[:court_photo][:event_id])
                if @event.update_attribute :main_photo, @court_photo.id
                    redirect_to @event
                end
            else
                redirect_to @court_photo.court
            end
        else
            flash[:error] = "Could not upload court photo."
            redirect_to @court_photo.court;
        end
    end

    def destroy
        @court_photo = CourtPhoto.find(params[:id])
        @court = @court_photo.court
        @court_photo.destroy
        flash[:info] = "Court photo deleted."
        redirect_to @court
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
            if params[:court_photo][:photo].try(:match, %r{^data:(.*?);(.*?),(.*)$})
                image_data = split_base64( params[:court_photo][:photo] )
                image_data_string = image_data[:data]
                image_data_binary = Base64.decode64(image_data_string)

                temp_img_file = Tempfile.new("data_uri-upload")
                temp_img_file.binmode
                temp_img_file << image_data_binary
                temp_img_file.rewind
                _timestamp = DateTime.now.strftime('%Q')
                img_params = {:filename => "court_photo_#{_timestamp}.#{image_data[:extension]}",
                            :type => image_data[:type], :tempfile => temp_img_file}
                uploaded_file = ActionDispatch::Http::UploadedFile.new(img_params)
                params[:court_photo][:photo] = uploaded_file
            end
            # return obj_hash
        end



        def court_photo_params
            params.require(:court_photo).permit(:photo, :court_id, :member_id)
        end

        def correct_user
            @court_photo = current_user.court_photos.find_by(id: params[:id])
            redirect_to root_url if @court_photo.nil?
        end
 end