class Post < ApplicationRecord
  enum post_type: [ :story, :job, :comment, :poll, :pollopt ]
end
