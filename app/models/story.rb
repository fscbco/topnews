# frozen_string_literal: true

class Story < ApplicationRecord
  serialize :raw_data, Hash
  has_many :likes

  def title
    raw_data.dig("title")
  end

  def by
    raw_data.dig("by")
  end

  def url
    raw_data.dig("url")
  end
end
