class Post < ApplicationRecord
  belongs_to :post_author, counter_cache: true
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  enum post_type: [ :story, :job, :comment, :poll, :pollopt ]
  scope :desc_stories, -> { where(post_type: :story).order(id: :desc) }
end
