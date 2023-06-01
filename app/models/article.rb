class Article < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true
  has_many :upvotes
end
