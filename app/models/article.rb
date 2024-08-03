class Article < ApplicationRecord
  belongs_to :user, optional: true
  # has_many :comments, dependent: :destroy

  # validates :author, presence: true
  # validates :descendants, presence: true
  validates :article_id, presence: true
  # validates :kids, presence: true
  # validates :score, presence: true
  # validates :time, presence: true
  # validates :title, presence: true
  # validates :type, presence: true
  # validates :url, presence: true
  # validate :must_be_bookmarked_by_user

  private

  def must_be_bookmarked_by_user
    if bookmarked && user.nil?
      errors.add(:base, 'Must be bookmarked by a user')
    end
  end
end