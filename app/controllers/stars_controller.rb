class StarsController < ApplicationController
    def create
        star = Star.new(user: current_user, story: @story)
        if star.save
            flash[:notice] = "Story starred successfully."
        else
            flash[:alert] = star.errors.full_messages.to_sentence if star.errors
        end
        redirect_back(fallback_location: root_path)
    end

    def destroy
        if @star.destroy
            flash[:notice] = "Story unstarred successfully."
        else
            flash[:alert] = star.errors.full_messages.to_sentence if star.errors
        end
        redirect_back(fallback_location: root_path)
    end


    private

    def set_star
        @star = Star.find(params[:id])
    end

    def set_story
        @story = Story.find(params[:story])
    end


end