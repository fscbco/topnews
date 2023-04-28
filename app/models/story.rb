# frozen_string_literal: true

class Story < ApplicationRecord
  validates :hn_id, presence: true
  validates :title, presence: true
  validates :url, presence: true
end
