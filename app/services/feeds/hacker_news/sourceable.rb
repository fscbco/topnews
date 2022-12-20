# frozen_string_literal: true

module Feeds
  module HackerNews
    # Indicates the human-readable name for the feed source.
    # TODO: We ultimately want to pull this from a FeedSource table.
    module Sourceable
      SOURCE_ID = 1
      SOURCE = 'Hacker News news feed'
      SOURCE_H = {
        source_id: SOURCE_ID,
        source: SOURCE,
      }
    end
  end
end
