class Item < ApplicationRecord
    
    validates :item_id, presence: true, uniqueness: true
    validates :item_created_at, presence: true
    validates :item_type, presence: true
    validates :by, presence: true
    validates :title, presence: true
    validates :url, presence: true
    
    acts_as_votable

    def voter_names
        self.votes_for.includes(:voter).map { |vote| vote.voter.full_name }.join(', ')
    end

    def voter_ids
        self.votes_for.includes(:voter).map { |vote| vote.voter.id }
    end
end
  