require_relative '../../lib/services/hacker_news/hacker_news.rb'

class ArticlesController < ApplicationController
  TOP_ARTICLES = 10
  def index
    get_top_stories_ids
    get_top_stories_details
    @articles
  end

  private

  # TODO: Refactor this articles or story to articles conversion
  # into its hown service class
  def get_top_stories_ids
    stories = hacker_news.topstories
    if stories
      @top_stories_ids = stories.take(TOP_ARTICLES)
      return @top_stories_ids
    end
  end

  def hacker_news
    @hn ||= HackerNews.new
  end

  def get_top_stories_details
    @top_stories = []
    return nil unless @top_stories_ids

    find_articles_by_stories_ids

    @articles.each do |article|
      if @top_stories_ids.include?(article.external_id)
        @top_stories_ids.delete(article.external_id)
      end
    end

    @top_stories_ids.each do |story_id|
      story = hacker_news.item(story_id)
      if story
        article = convert_story_to_article(story)
        @articles << article
      end
    end
  end

  def find_articles_by_stories_ids
    @articles = Article.where(external_id: @top_stories_ids).to_a
  end

  def convert_story_to_article(story)
    story["document"] = story.clone
    story["external_id"] = story["id"]
    story.delete("id")
    return Article.new(story.slice(*Article.attribute_names))
  end
end
