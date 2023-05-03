class StarsController < ApplicationController

    before_action :set_story, only: [:create]
    before_action :set_star, only: [:destroy]

    def create
        star = Star.new(user: current_user, story: @story)
        if star.save
            flash[:notice] = "Story starred successfully."
        else
            flash[:alert] = "Story starred unsuccessfully, try again later."
            Rails.logger.error star.errors.full_messages
        end
        redirect_back_or_to(root_path)
    end

    def destroy
        if @star.destroy
            flash[:notice] = "Story unstarred successfully."
        else
            flash[:alert] = "Story unstarred unsuccessfully, try again later.."
            Rails.logger.error star.errors.full_messages
        end
        redirect_back_or_to(root_path)
    end


    private

    def set_star
        @star = Star.find(params[:id])
    end

    def set_story
        @story = Story.find(params[:story])
    end
end
