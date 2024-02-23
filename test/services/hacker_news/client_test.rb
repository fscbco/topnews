require "test_helper"

class HackerNews::ClientTest < ActiveSupport::TestCase
  test "top_stories" do
    VCR.use_cassette("hacker_news_top_stories") do
      client = HackerNews::Client.new
      response = client.top_stories

      assert_equal 200, response.status
    end
  end

  test "item" do
    VCR.use_cassette("hacker_news_item") do
      client = HackerNews::Client.new
      response = client.item(39382092)

      assert_equal 200, response.status
    end
  end
end
