require "test_helper"

class HackerNews::TopStoriesServiceTest < ActiveSupport::TestCase
  test "gets info on item" do
    VCR.use_cassette("hacker_news_item") do
      service = HackerNews::ItemService.new(39382092)
      item = service.call

      assert item[:title].present?
    end
  end
end
