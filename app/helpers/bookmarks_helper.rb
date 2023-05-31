module BookmarksHelper
  def story_bookmarked?(story_id)
    current_user.bookmarks.exists?(story_id: story_id)
  end
end
