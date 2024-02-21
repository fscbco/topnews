# frozen_string_literal: true

require "rails_helper"

RSpec.describe(FetchTopStoriesFromApiService, type: :service, vcr: true) do
  before(:each) do
    Rails.cache.clear
  end

  after(:each) do
    Rails.cache.clear
  end

  describe ".call" do
    it "calls the service and returns an array of integers" do
      limit = 10
      response = FetchTopStoriesFromApiService.new(limit: limit).call
      expect(response.count).to eq(limit)
      response.each do |id|
        expect(id.is_a?(Integer)).to eq(true)
      end
    end

    it "won't call the API twice" do
      limit = 5
      expect(HTTParty).to receive(:get).once.and_call_original
      first_call_result = FetchTopStoriesFromApiService.new(limit: limit).call

      sleep 1

      # Second call: Should not trigger an HTTP interaction, indicating cache hit
      expect(HTTParty).not_to receive(:get)
      second_call_result = FetchTopStoriesFromApiService.new(limit: limit).call

      expect(second_call_result).to eq(first_call_result)
    end
  end
end
