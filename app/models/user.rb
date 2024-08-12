class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :likes, foreign_key: "user_id"

  def liked_stories
    likes = Like.where(user_id: self.id)
    stories = Story.where(id: likes.map {|m| m.story_id })
    return stories
  end

  def username
    self.first_name.concat(self.last_name).downcase
  end

end
