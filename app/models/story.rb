class Story < ApplicationRecord
  has_many :likes, foreign_key: "story_id"
  validates :hackernewsid, presence: true
  validates :title, presence: true
  validates :url, presence: true
  validates :hn_created_at, presence: true

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end

  def liked_by
    likes = self.likes.where(story_id: self.id)
    users = User.where(id: likes.map { |like| like.user_id })
    return users
  end

end
