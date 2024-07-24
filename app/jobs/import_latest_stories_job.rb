#frozen_string_literal: true

class ImportLatestStoriesJob < ApplicationJob
  LOG_FILE = Rails.root.join('log', 'fetch_latest_stories.log').to_s

  queue_as :default
  
  def initialize
    super
    @logger = Logger.new(LOG_FILE)
  end

  def perform
    log_message("BEGIN Fetching data from Top Stories API")

    begin
      ImportTopStories.call
    rescue => e
      log_error("Failed to fetch stories. Error: #{e}")
    ensure
      log_message("END Fetching data from Top Stories API")
    end
  end

  private

  attr_reader :logger

  def log_message(message)
    logger.info(message)
  end

  def log_error(error)
    logger.error(error)
  end
end