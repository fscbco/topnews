module StoriesHelper
  def story_url(story)
    story.respond_to?(:url) ? story.url : story[:url]
  end

  def story_title(story)
    story.respond_to?(:title) ? story.title : story[:title]
  end

  def story_author(story)
    story.respond_to?(:author) ? story.author : story[:author]
  end

  def story_type(story)
    story.respond_to?(:story_type) ? story.story_type : story[:type]
  end

  def story_published_at(story)
    if story.respond_to?(:published_at) && story.published_at
      story.published_at.strftime("%Y-%m-%d %H:%M:%S")
    elsif story[:published_at]
      Time.at(story[:published_at]).strftime("%Y-%m-%d %H:%M:%S")
    else
      'Not available'
    end
  end
end