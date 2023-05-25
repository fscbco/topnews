class Story < ActiveRecord::Base
    acts_as_votable
    has_many :upvotes, as: :voteable
    has_many :users

    def upvotes
    upvotes.where(value: 1).count
    end
    
    def downvotes
    upvotes.where(value: -1).count
    end

    def points
    upvotes.sum(:value)
    end

    def update_rank
    age = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = points + age

    update_attribute(:rank, new_rank)
    end
end