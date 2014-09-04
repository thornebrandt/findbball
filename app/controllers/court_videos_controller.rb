class CourtVideosController < ApplicationController
    before_action :signed_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @court_video = current_user.court_videos.build( court_video_params )
        if @court_video.save
            flash[:success] = "Court video updated"
            redirect_to @court_video.court
        else
            flash[:error] = "Could not save court video.";
            redirect_to @court_video.court;
        end
    end

    def destroy
        @court_video = CourtVideo.find(params[:id])
        @court = @court_video.court
        @court_video.destroy
        flash[:info] = "Court video deleted."
        redirect_to @court
    end

    private

        def court_video_params
            params.require(:court_video).permit(:vi, :court_id, :member_id)
        end

        def correct_user
            @court_video = current_user.court_videos.find_by(id: params[:id])
            redirect_to root_url if @court_video.nil?
        end
 end