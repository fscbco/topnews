# frozen_string_literal: true

# app/services/download_posts_service.rb
# Description: This service is responsible for downloading Hacker News Posts into the system
#              It currently only supports stories, but it could be refactored to store all
#              types of posts.


class DownloadPostsService

  # class level function to 
  def self.download_stories(count=20)
    new.download_stories(count)
  end

  def download_stories(count=20)
    hn_post_ids = HackerNewsClient.fetch_top_stories
    max_post_id = Post.last&.id || 0

    hn_post_ids.first(count).each do |post_id|
      break if post_id <= max_post_id

      post = HackerNewsClient.fetch_story_details(post_id)
      # make sure to only save stories
      next unless post['type'] == 'story'

      post_author = PostAuthor.find_or_create_by! name: post['by']

      Post.find_or_create_by!(
        id: post['id'],
        title: post['title'],
        posted_at: Time.at(post['time']),
        post_type: post['type'],
        url: post['url'],
        score: post['score'],
        post_author_id: post_author.id
      )
    rescue StandardError => e
      Rails.logger.error "Error downloading post #{post_id}: #{e.message}"
    end
  end
end
