class Story < ApplicationRecord
    has_many :starred_stories
    has_many :users, through: :starred_stories
  
    validates :hacker_news_id, presence: true, uniqueness: true
    def starred_by_names
        users.map(&:full_name).reject(&:blank?).join(', ')
    end
end
