class NewsStory < ApplicationRecord
  STORIES_PER_PAGE = 25

  belongs_to :user, optional: true, foreign_key: :pinned_by_id

  scope :pinned, -> { where.not(pinned_by_id: nil) }
  
  def pinned_by?(active_user)
    user === active_user
  end

  def fullname_of_pinner
    return if user.nil?

    user.first_name + " " +  user.last_name
  end
end