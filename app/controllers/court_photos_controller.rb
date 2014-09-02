class CourtPhotosController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @court_photo = current_user.court_photos.build(court_photo_params)
        if @court_photo.save
            flash[:success] = "Court photo uploaded"
            redirect_to @court_photo.court
        else
            flash[:error] = "Could not upload court photo.";
            redirect_to @court_photo.court;
        end
    end

    def destroy
        @court_photo = CourtPhoto.find(params[:id])
        @court = @court_photo.court
        @court_photo.destroy
        flash[:info] = "Court photo deleted."
        redirect_to @court_photo
    end

    private

        def court_photo_params
            params.require(:court_photo).permit(:photo, :court_id, :member_id)
        end

        def correct_user
            @court_photo = current_user.court_photos.find_by(id: params[:id])
            redirect_to root_url if @court_photo.nil?
        end
 end