class User < ApplicationRecord
  has_many :hacker_news_recommendations, dependent: :destroy
  has_many :hacker_news_stories, through: :hacker_news_recommendations

  alias_attribute :recommended_stories, :hacker_news_stories

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end
end
