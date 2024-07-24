class Post < ApplicationRecord
  belongs_to :post_author, counter_cache: true
  enum post_type: [ :story, :job, :comment, :poll, :pollopt ]
end
