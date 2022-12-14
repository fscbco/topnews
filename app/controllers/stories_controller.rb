# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :update_top_stories, only: :index

  def index
    @stories = Story.where(hacker_news_id: top_stories_ids).includes(:users)
  end

  private

  def top_stories
    @top_stories ||= Story.where(hacker_news_id: top_stories_ids)
  end

  def top_stories_ids
    @top_stories_ids ||= HackerNews.new.top_stories_ids[0..50]
  end

  def missing_stories
    top_stories_ids - top_stories.pluck(:hacker_news_id)
  end

  def update_top_stories
    missing_stories.each do |hn_id|
      story = Story.find_or_initialize_by(hacker_news_id: hn_id)
      next if story.persisted?

      hn_story = HackerNews.new.story(hn_id)
      story.update_story(hn_story)
    end
  end
end
