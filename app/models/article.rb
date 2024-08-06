class Article < ApplicationRecord
  has_many :bookmarks
  has_many :users, through: :bookmarks

  belongs_to :user, optional: true

  validates :article_id, presence: true


  def bookmarked_users
    # self.bookmarks.map(&:user).map(&:full_name).uniq
    self.bookmarks.map(&:user).uniq
  end

end