class Article < ApplicationRecord
  has_many :bookmarks
  has_many :users, through: :bookmarks

  validates :article_id, presence: true
  validates :author, presence: true
  validates :title, presence: true
  validates :url, presence: true

  def bookmarked_users
    self.bookmarks.map(&:user).uniq
  end
end