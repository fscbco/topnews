class Story < ApplicationRecord
  has_many :flags, dependent: :destroy
  has_many :flagged_by_users, through: :flags, source: :user

  validates :title, presence: true, uniqueness: { scope: :url }
  validates :url, presence: true
end
