# frozen_string_literal: true

class Upvote < ApplicationRecord
    acts_as_votable
    belongs_to :user
    belongs_to :story
    belongs_to :voteable, polymorphic: true

    validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." } 
    
    def up_vote?
        value == 1
    end
    
    def down_vote?
        value == -1
    end
end
  