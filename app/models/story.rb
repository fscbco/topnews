# frozen_string_literal: true

class Story < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :hacker_news_id, presence: true, uniqueness: true
  validates :author, presence: true
  validates :time, presence: true
  validates :title, presence: true
  validates :url, presence: true

  scope :newest_first, -> { order(time: :desc) }
end
