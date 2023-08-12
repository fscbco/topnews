# spec/services/yc_connector_spec.rb

require 'rails_helper'

describe YcConnector do
  describe "#initialize" do
    it "sets @feed_type to 'topstories' by default" do
      yc_connector = YcConnector.new
      expect(yc_connector.instance_variable_get(:@feed_type)).to eq("topstories")
    end

    it "sets @feed_type based on the provided type" do
      yc_connector = YcConnector.new("best")
      expect(yc_connector.instance_variable_get(:@feed_type)).to eq("beststories")
    end
  end
  
  describe "#service_url" do
    it "returns the correct service URL" do
      yc_connector = YcConnector.new
      expect(yc_connector.send(:service_url)).to eq("https://hacker-news.firebaseio.com/v0/")
    end
  end

  describe "#get_stories" do
    it "returns a list of item ids" do
      yc_connector = YcConnector.new
      allow(HTTParty).to receive(:get).and_return([1, 2, 3])
      expect(yc_connector.get_stories).to eq([1, 2, 3])
    end
  end

  describe "#load_item" do
    it "returns the body of the HTTP response" do
      yc_connector = YcConnector.new
      allow(HTTParty).to receive(:get).and_return(double(body: "item_body"))
      expect(yc_connector.load_item(123)).to eq("item_body")
    end
  end

  describe "#build_feed" do
    it "builds a feed based on item ids" do
      yc_connector = YcConnector.new
      allow(yc_connector).to receive(:get_stories).and_return([1, 2, 3])
      allow(yc_connector).to receive(:load_item).and_return('{"title": "Test Title"}')
      
      feed = yc_connector.build_feed(page: 1)
      
      expect(feed).to be_instance_of(Array)
      expect(feed.length).to eq(3)
      expect(feed.first).to have_key("title")
    end
  end

  describe "#feed_type" do
    it "returns 'topstories' for type 'top'" do
      yc_connector = YcConnector.new("top")
      expect(yc_connector.send(:feed_type, "top")).to eq("topstories")
    end

    it "returns 'beststories' for type 'best'" do
      yc_connector = YcConnector.new("best")
      expect(yc_connector.send(:feed_type, "best")).to eq("beststories")
    end

    it "returns 'newstories' for unknown type" do
      yc_connector = YcConnector.new("unknown")
      expect(yc_connector.send(:feed_type, "unknown")).to eq("newstories")
    end
  end
end
