require 'rails_helper'
RSpec.describe PollHackerNewsJob do
  subject(:service) { described_class }

  let(:news_detail) { NewsDetail.create(hn_id: 1) }
  describe '#perform' do
    it 'intial perfrom populates db' do
      service.new.perform
      expect(NewsDetail.count > 0).to be true
    end

    it 'addtional performs will add to db' do
      news_detail
      service.new.perform
      expect(NewsDetail.count > 1).to be true
    end
  end
end
