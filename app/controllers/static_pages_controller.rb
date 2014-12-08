class StaticPagesController < ApplicationController
    def home
    	@hero = true
        @video_articles = VideoArticle.limit(4)
    end

    def splash
    	@noHeaderFooter = true
    end



end
