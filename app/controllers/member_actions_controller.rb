class MemberActionsController < ApplicationController
    def log
        @noHeaderFooter = true
        @member_actions = MemberAction.all().order("created_at DESC").limit(50)
    end


    private
        def member_action_params
            params.require(:member_action).permit(:member_id, :action_text, :link_id, :linkType, :level)
        end

end