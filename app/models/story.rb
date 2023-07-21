class Story < ApplicationRecord
  validates_presence_of :story_id
  validates_uniqueness_of :story_id

  has_many :starrables, dependent: :destroy
  has_many :users, through: :starrables
end
