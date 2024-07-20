class RecordHnItemJob
  include Sidekiq::Job

  def perform(id)
    client = HackerNewsClient.new
    item = client.fetch_item(id)

    recorder = HackerNewsStoryRecorder.new(api_response: item)
    recorder.execute
  end
end
