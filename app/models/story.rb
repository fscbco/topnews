# frozen_string_literal: true

class Story < ApplicationRecord
  include Draper::Decoratable

  belongs_to :parent, class_name: "Story", optional: true
  has_many :stories, class_name: "Story", foreign_key: "parent_id"
  has_many :flagged_stories, dependent: :destroy
  has_many :users, through: :flagged_stories

  scope :not_deleted, -> { where deleted: [ nil, false ] }
  scope :not_dead, -> { where dead: [ nil, false ] }

  def flag! user:
    FlaggedStory.find_or_create_by( story_id: id, user: user )
  end
end
