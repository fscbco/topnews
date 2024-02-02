class Story < ApplicationRecord
  has_many :stars, dependent: :destroy
  has_many :starring_users, through: :stars, source: :user
end