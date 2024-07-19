class Star < ApplicationRecord
  belongs_to :user

  validates :story_id, presence: true
  validates :story_title, presence: true
  validates :story_url, presence: true

end
