class PullFeedsJob
  include Sidekiq::Job

  class << self
    def running?
      Sidekiq::Workers.new.any? do |_, _, worker|
        JSON.parse(worker['payload'])['class'] == name
      end
    end
  end

  def perform(*args)
    # TODO: Make limit value configurable.
    delete_all_non_recommended!
    feed_items = prepare_feed_items_for_upsert
    Feed.upsert_all(feed_items, returning: false, record_timestamps: true, unique_by: %i[feed_item_id source_id])
  rescue => e
    Rails.logger.error("Error pulling news feeds: #{e}")
  end

  private

  # Adds our news feed source information - real world should
  # get this from the database.
  def prepare_feed_items_for_upsert
    TopNewsService.new(limit: 500).execute.each do |feed_item|
      feed_item.merge!(Feeds::HackerNews::Sourceable::SOURCE_H)
    end
  end

  # Make sure we save our recommended feeds; purge the rest in
  # prep for bringing in the new top stories.
  def delete_all_non_recommended!
    recommended_feed_ids = Feed.recommended_feed_items.pluck(:id)
    Feed.where.not(id: recommended_feed_ids).destroy_all
  end
end
