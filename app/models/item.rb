class Item < ApplicationRecord
    acts_as_votable
  
    validates :item_id, presence: true, uniqueness: true
    validates :item_created_at, presence: true
    validates :item_type, presence: true
    validates :by, presence: true
    validates :title, presence: true
    validates :url, presence: true
end
  