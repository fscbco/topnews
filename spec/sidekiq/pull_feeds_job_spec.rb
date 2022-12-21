require 'rails_helper'
RSpec.describe PullFeedsJob, type: :job do
  subject(:pull_feeds_job) do
    PullFeedsJob.new.perform
  end

  context 'when running the job' do
    it 'returns the new feed items' do
      VCR.use_cassette('run_pull_feeds_job') do
        pull_feeds_job
        expect(Feed.count).to eq 451
      end
    end
  end

  context 'when running the job with existing recommended feeds' do
    let(:user) do
      User.create(first_name: 'Gene', last_name: 'Angelo', email: 'gene@b.com', password: 'password')
    end

    it 'retains the existing recommended feed items' do
      VCR.use_cassette('run_pull_feeds_job') do
        pull_feeds_job
        expect(Feed.count).to eq 451
        user.feeds << Feed.all.sample(10)
        pull_feeds_job
        expect(Feed.count).to eq 451
        expect(Feed.recommended_feed_items.count).to eq 10
      end
    end
  end
end
