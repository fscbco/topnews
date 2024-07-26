class Post < ApplicationRecord
  belongs_to :post_author, counter_cache: true
  enum post_type: [ :story, :job, :comment, :poll, :pollopt ]

  scope :desc_stories, -> { where(post_type: :story).order(id: :desc) }
end
