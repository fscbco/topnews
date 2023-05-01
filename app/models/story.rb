# frozen_string_literal: true

class Story < ApplicationRecord
  validates :hn_id, presence: true
  validates :title, presence: true

  has_many :stars
  has_many :users, through: :stars
end
