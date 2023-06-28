class UserStoriesController < ApplicationController
    def create
        UserStory.create(
            user: current_user,
            story: Story.find(params[:story_id])
        )
    rescue StandardError => e
        flash.alert = 'Unable to save story'
    ensure
        redirect_to root_path
    end

    def destroy
        UserStory.find_by(
            user: current_user,
            story: Story.find(params[:story_id])
        )
        &.destroy!
    rescue StandardError => e
        flash.alert = 'Unable to unsave story'
    ensure
        redirect_to root_path
    end
end
