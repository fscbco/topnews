class Story < ApplicationRecord
  validates :external_id, presence: true
  validates :title, presence: true
  validates :author, presence: true
end
