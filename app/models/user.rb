class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookmarks
  has_many :articles, through: :bookmarks

  # Check if the user has bookmarked a specific article
  def bookmarked?(article)
    bookmarks.exists?(article_id: article.id)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
