class FlaggedStory < ApplicationRecord
    has_and_belongs_to_many :users, validate: true
    validates_presence_of :url, :title
end
