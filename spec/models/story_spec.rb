require "rails_helper"

RSpec.describe Story, type: :model do
  describe "methods" do
    it "returns title" do
      title = "Hi there"
      story = Story.new(raw_data: {"title" => title})

      expect(story.title).to eq(title)
    end

    it "returns by" do
      by = "Jeff Goldblum"
      story = Story.new(raw_data: {"by" => by})

      expect(story.by).to eq(by)
    end

    it "returns url" do
      url = "https://www.kasheesh.co"
      story = Story.new(raw_data: {"url" => url})

      expect(story.url).to eq(url)
    end
  end
end
