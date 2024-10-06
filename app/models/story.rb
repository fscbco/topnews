class Story < ApplicationRecord
  has_many :starred_stories, dependent: :destroy

  def starred_by_names
    starred_stories.joins(:user).pluck('users.first_name', 'users.last_name').map { |name| name.join(' ') }
  end
end
