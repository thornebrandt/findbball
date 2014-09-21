class StaticPagesController < ApplicationController
    def home
    	@hero = true
    end

    def splash
    	@noHeaderFooter = true
    end

end
