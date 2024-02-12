require "rails_helper"

describe "fetching the top stories off hacker news" do
  context "fetching a top stories for the first time" do
    it "creates story records for each story" do
      author1 = "jsmith"
      title1 = "foobar"
      url1 = "www.foobar.com"
      author2 = "msmith"
      title2 = "bazbop"
      url2 = "www.bazbop.com"
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json").to_return_json(body: ["1","2"])
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/1.json").to_return_json(body: {"by" => author1, "title" => title1, "url" => url1 })
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/2.json").to_return_json(body: {"by" => author2, "title" => title2, "url" => url2 })

      expect {
        FetchTopStories.call
      }.to change {
        Story.count
      }.by(2)

      story1 = Story.find_by!(external_id: "1")
      expect(story1.author).to eq(author1)
      expect(story1.title).to eq(title1)
      expect(story1.url).to eq(url1)

      story2 = Story.find_by!(external_id: "2")
      expect(story2.author).to eq(author2)
      expect(story2.title).to eq(title2)
      expect(story2.url).to eq(url2)
    end
  end

  context "fetching a top stories for the second time" do
    it "finds the exising stories instead of creating them again" do
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json").to_return_json(body: ["1","2"])
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/1.json").to_return_json(body: {"by" => "jsmith", "title" => "title1", "url" => "url1"})
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/2.json").to_return_json(body: {"by" => "msmith", "title" => "title2", "url" => "url2"})

      expect {
        FetchTopStories.call
      }.to change {
        Story.count
      }.by(2)

      expect {
        FetchTopStories.call
      }.to change {
        Story.count
      }.by(0)
    end
  end
end
