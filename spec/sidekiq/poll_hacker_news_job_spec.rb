require 'rails_helper'
RSpec.describe PollHackerNewsJob  do
  subject(:service) { described_class}


  let(:news_detail) { NewsDetail.create(hn_id: 1)}
  describe '#perform' do
    it 'intial perfrom populates db' do
      
      service.new.perform      
      expect(NewsDetail.count).to eq(500)
    end

    it 'addtional performs will add to db' do
      news_detail
      service.new.perform
      expect(NewsDetail.count).to eq(501)
    end
  end
end
