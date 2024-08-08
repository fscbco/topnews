class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookmarks
  has_many :articles, through: :bookmarks

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  
  # Check if the user has bookmarked a specific article
  def bookmarked?(article)
    bookmarks.exists?(article_id: article.id)
  end

  # Convenience method for user's full name
  def full_name
    "#{first_name} #{last_name}"
  end

end
