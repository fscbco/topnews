class Post < ApplicationRecord
  validates :author, presence: true
  validates :hn_created_at, presence: true
  validates :hn_id, presence: true, uniqueness: { case_sensitive: false }
  validates :post_type, presence: true
  validates :title, presence: true
  validates :url, presence: true

  has_many :stars, dependent: :destroy
  has_many :starred_users, class_name: 'User', foreign_key: 'user_id', through: :stars, source: :user
end
