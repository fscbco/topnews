class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :starred_stories
  has_many :stories, through: :starred_stories

  def star_story(story)
    stories << story unless stories.include?(story)
  end

  def unstar_story(story)
    stories.delete(story)
  end
  
  def full_name
    "#{first_name} #{last_name}".strip
  end
end
