class StaticPagesController < ApplicationController
    def home
    	@hero = true
        logger.debug "This is from debug --- ?"
        logger.info "This is from info ---???"
    end

    def splash
    	@noHeaderFooter = true
    end



end
