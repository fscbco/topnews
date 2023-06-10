class Story < ApplicationRecord
  has_many :user_stories
  has_many :starring_users, through: :user_stories, source: :user
  
  scope :starred, -> { where(starred: true)}

  class StoryNotFoundError < StandardError
    def initialize(message = "Our fault! Story not found")
      super(message)
    end
  end
  
  def star_by(user)
    update(starred: true) unless starred?
    user_stories.create(user: user)
  rescue StandardError => e
    Rails.logger.error("Error starring the story: #{e.message}")
    raise StoryNotFoundError, e.message
  end
end
