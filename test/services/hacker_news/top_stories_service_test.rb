require "test_helper"

class HackerNews::ItemServiceTest < ActiveSupport::TestCase
  test "gets info on story" do
    VCR.use_cassette("hacker_news_top_stories") do
      service = HackerNews::TopStoriesService.new
      top_stories = service.call

      assert_kind_of Array, top_stories
      assert_kind_of Integer, top_stories.first
    end
  end
end
