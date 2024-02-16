class Like < ApplicationRecord
  belongs_to :user

  def self.get_users(story_id)
    where(story_id: ).map(&:user).uniq.map(&:email).join(", ")
  end
end
