require 'rails_helper'

RSpec.describe FetchHnTopStoriesJob, type: :job do
  let!(:story) { create(:hacker_news_story, hacker_news_id: 1) }
  let(:expected_story_ids_to_fetch) { [2, 3] }

  before do
    allow_any_instance_of(HackerNewsClient).to receive(:top_story_ids).and_return([1, 2, 3])
  end

  it 'creates a job to fetch each story that has not already been saved' do
    expected_story_ids_to_fetch.each { |id| expect(RecordHnItemJob).to receive(:perform_async).with(id) }
    described_class.new.perform
  end
end
