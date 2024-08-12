require 'rails_helper'

RSpec.describe UpdatePostsJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { UpdatePostsJob.perform_later(100) }

  it 'queues the job' do
    expect { job }
      .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it 'is in urgent the default' do
    expect(UpdatePostsJob.new.queue_name).to eq('default')
  end

  it 'executes perform' do
    expect(DownloadPostsService).to receive(:download_stories).with(100)
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
