# frozen_string_literal: true

class Story < ApplicationRecord
  include Draper::Decoratable

  has_many :flagged_stories
  has_many :users, through: :flagged_stories

  scope :not_deleted, -> { where deleted: [ nil, false ] }
  scope :not_dead, -> { where dead: [ nil, false ] }

  def flag! user:
    FlaggedStory.find_or_create_by( story_id: id, user: user )
  end
end
