class ArticleStarer < ApplicationService
    def initialize(user_id, story_id)
      @user_id = user_id
      @story_id = story_id
    end

    def call
        user = User.find(@user_id)
        story = Story.find(@story_id)
        if user.stories.include?(story)
            user.stories.delete(story)
        else
            user.stories << story
        end
    end

end