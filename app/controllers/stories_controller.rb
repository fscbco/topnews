# frozen_string_literal: true

# Controller for flagged stories
class StoriesController < ApplicationController
    def index
        stories = FlaggedStory.includes(:flags => :user)

        @flagged_stories = stories.map do |story|
            users = story.flags.map do |flag|
                "#{flag.user.first_name} #{flag.user.last_name}"
            end.join(', ')

            { :story => story, :users => users }
        end
    end

    def create
        story = FlaggedStory.find_or_create_by!(
            :title => params[:title],
            :url => params[:url],
            :hn_id => params[:id],
            :hn_url => params[:hn_url]
        )

        flag = Flag.find_or_create_by!(:flagged_story_id => story.id, :user_id => params[:user_id])

        flash[:notice] = 'There was an error flagging the story.' unless flag.present?

        redirect_to stories_path
    end
end
