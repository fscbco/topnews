class TopStory < ApplicationRecord
    belongs_to :source

    def self.latest
        order(created_at: :desc).first
    end
end
