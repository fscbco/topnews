class HrNewsService

  def self.fetch_and_update_stories(limit = 25)
      hr_news_stories = HackerRankNews.new
      hr_news = hr_news_stories.get_top_stories.first(limit)

      hr_news.each do |story_id|
        ActiveRecord::Base.transaction do
          single_story = hr_news_stories.get_story(story_id)

          if single_story["type"] == "story" && single_story["url"].present?
            story = Story.find_or_initialize_by(story_id: story_id)
            if story.new_record?
            story.assign_attributes(
                title: single_story["title"],
                by: single_story["by"],
                text: single_story["text"],
                url: single_story["url"],
                score: single_story["score"],
                time: Time.at(single_story["time"].to_i),
                story_type: single_story["type"]
            )
            unless story.save
                Rails.logger.error("Error saving story: #{story.errors.full_messages.to_sentence}")
                raise ActiveRecord::Rollback
            end
          end
        end
      end
    end
  end
end