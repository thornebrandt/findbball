class VideoArticlesController < ApplicationController
    before_action :admin_user

    def new
        @video_article = VideoArticle.new
    end

    def create
        @video_article = VideoArticle.new(video_article_params)
        if @video_article.save!

        end
    end

    private
    def video_article_params
        params.require(:video_article).permit(:title, :priority, :vi, :member_id)
    end
end