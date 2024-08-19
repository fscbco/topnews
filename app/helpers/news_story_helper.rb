module NewsStoryHelper
  def thumbtack_class(news_story)
    news_story.pinned_by_id.nil? ? 'unpinned-thumbtack-icon' : 'pinned-thumbtack-icon'
  end

  def format_time(time)
    (time_ago_in_words(time) + ' ago!').gsub('about', '')
  end

  def disable_unpinning(news_story)
    return '' if news_story.pinned_by_id.nil?

    pinned_by_current_user(news_story) ? '' : 'disabled_link'
  end

  private

  def pinned_by_current_user(news_story)
    news_story.pinned_by?(current_user)
  end
end