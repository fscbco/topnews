class StoriesController < ApplicationController
  def index
    @stories = Story.order(created_at: :desc).limit(30)
    # @flagged_stories = FlaggedStory.includes(:user, :story)
    flagged_stories_data = FlaggedStory.includes(:user, :story)
                                       .group_by(&:story)
                                       .map do |story, flagged_stories|
                                          { story: story,
                                            count: flagged_stories.count,
                                            user_names: flagged_stories.map { |fs| fs.user.name }.join(', ') }
                                        end

    @flagged_stories = flagged_stories_data.sort_by { |data| -data[:count] }
  end

  def flag
    story = Story.find(params[:id])
    flagged_story = FlaggedStory.find_or_initialize_by(user: current_user, story: story)

    if flagged_story.new_record?
      flagged_story.save
      flash[:notice] = "Story flagged successfully."
    else
      flash[:alert] = "You have already flagged this story."
    end

    redirect_to stories_path
  end

end
