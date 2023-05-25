module ApplicationHelper

    def up_vote
        @votes = update_vote!(1)
        redirect_to :back
        end
        
        def down_vote
        @votes = update_vote!(-1)
        redirect_to :back
        end
        
end
