class VideoArticlesController < ApplicationController
    before_action :admin_user

    def video_articles
        @video_article = VideoArticle.new
        @video_articles = VideoArticle.order('priority').limit(16)
    end

    def create
        @video_article = VideoArticle.new(video_article_params)
        if @video_article.save!
            if !@video_article.priority
                if @video_article.update_attribute(:priority, @video_article.id)
                    current_user.log("created a video article")
                    redirect_to action: 'video_articles'
                end
            else
                current_user.log("created a video article with priority #{@video_article.priority}")
                redirect_to action: 'video_articles'
            end
        end
    end

    def update
        @video_article = VideoArticle.find(params[:id])
        respond_to do |format|
            if @video_article.update_attributes(video_article_params)
                format.html { redirect_to action: 'video_articles', notice: "Video article successfully updates." }
                current_user.log("edit a video article")
            else
                format.html { render action: 'video_articles', notice: "video updating failed" }
            end
        end
    end

    def destroy
        @video_article = VideoArticle.find(params[:id])
        if @video_article.destroy
            flash[:info] = "Video Article deleted."
            redirect_to action: 'video_articles'
        else
            flash[:warning] = "Video article not deleted"
            redirect_to action: 'video_articles'
        end
    end

    private
    def video_article_params
        params.require(:video_article).permit(:title, :priority, :vi, :member_id)
    end
end