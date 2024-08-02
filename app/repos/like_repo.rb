class LikeRepo
  def initialize(user_id)
    @user_id = user_id
  end

  def toggle_like(story_id)
    like = Like.find_or_create_by(
      story_id: story_id,
      user_id: user_id
    )
    like.toggle!(:active)
    self
  end

  def self.fetch_grouped_likes(story_ids = [])
    likes = story_ids.blank? ?
      fetch_all_likes :
      fetch_likes(story_ids)

    likes
      .group_by { |like| like[:story_id] }
      .transform_values do |likes|
        likes
          .map { |like| like[:name] }
          .join(", ")
      end
  end

  def self.fetch_likes(story_id)
    likes = Like
      .includes(:user)
      .where(
        story_id: story_id,
        active: true
      )

    likes.map { |like| format_like(like) }
  end

  def self.fetch_all_likes
    likes = Like
      .includes(:user)
      .where(
        active: true
      )
      .order(id: :desc)

    likes.map { |like| format_like(like) }
  end

  def self.format_like(like)
    {
      story_id: like.story_id,
      user_id: like.user_id,
      name: like.user_name
    }
  end

  private

  attr_reader :user_id
end
