module StoryHelper

    def starred_by_user(story)
        story.stars.find_by(user: current_user)
    end
end