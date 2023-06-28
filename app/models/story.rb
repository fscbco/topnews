class Story < ApplicationRecord
    belongs_to :source
    has_many :user_stories
    has_many :users, through: :user_stories

    scope :from_hacker_news, -> { joins(:source).where(source: { name: Source::HACKER_NEWS }) }
end
