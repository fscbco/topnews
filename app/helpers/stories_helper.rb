module StoriesHelper
  def self.get_story_likes(story_ids)
    story_likes = {}
    likes = Like.where(story_id: story_ids)
    users = User.get_first_names(likes.pluck(:user_id).uniq)
    likes.each do |like|
      story_likes[like.story_id] ||= {}
      story_likes[like.story_id][like.user_id] = users[like.user_id]
    end
    story_likes
  end
end
