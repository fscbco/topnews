# frozen_string_literal: true

class FindOrCreateStoryService
  attr_reader :id

  def initialize(id:)
    @id = id
  end

  def call
    if story.present?
      story
    else
      Story.create(hacker_news_id: hacker_news_id, raw_data: raw_data)
    end
  end

  private

  def hacker_news_id
    raw_data.dig("id")
  end

  def raw_data
    @_raw_data ||= HTTParty.get("https://hacker-news.firebaseio.com/v0/item/#{id}.json").to_h
  end

  def story
    @_story ||= Story.find_by(hacker_news_id: id)
  end
end
