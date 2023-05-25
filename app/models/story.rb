class Story < ActiveRecord::Base
    has_many :upvotes, as: :voteable
    has_many :users

    def up_votes
    votes.where(value: 1).count
    end
    
    def down_votes
    votes.where(value: -1).count
    end

    def points
    votes.sum(:value)
    end

    def update_rank
    age = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
    new_rank = points + age

    update_attribute(:rank, new_rank)
    end
    
    default_scope { order('rank DESC') }
    scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }

    def save_with_initial_vote
    ActiveRecord::Base.transaction do
    self.create_vote
    self.save
    end
    end

    def create_vote
    user.votes.create(value: 1, post: self)
    end
end