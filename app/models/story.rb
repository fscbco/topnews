class Story < ApplicationRecord
    belongs_to :source

    scope :from_hacker_news, -> { joins(:source).where(source: { name: Source::HACKER_NEWS }) }
end
