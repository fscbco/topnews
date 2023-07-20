class Story < ApplicationRecord
  validates :external_id, :title, :url, presence: true

  has_many :stars, dependent: :destroy, class_name: 'UserStory'
  has_many :users, through: :stars
end
