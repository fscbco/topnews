# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :story
  belongs_to :user

  validates :story_id, presence: true
  validates :user_id, presence: true
  validates :story_id, uniqueness: { scope: :user_id }
end
