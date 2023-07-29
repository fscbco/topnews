class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :stories

  def starred_stories
    Story.where(:user_id => self.id)
  end
end
