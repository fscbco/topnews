require 'rails_helper'

describe Article do
  context 'creating a new article' do
    let(:document) do
      {
        external_id: 41247023,
        kids: [41247704, 41247268],
        descendants: 496,
        title: "Show HN: If YouTube had actual channels",
        url: "https://ytch.xyz",
        type: "story",
        score: 2554,
        time: 1723648206,
        by: "hadisafa"
      }
    end
    let(:attrs) do
      {
        external_id: 41247023,
        document: document,
        title: "Show HN: If YouTube had actual channels",
        url: "https://ytch.xyz",
        type: "story",
        score: 2554,
        time: 1723648206,
        by: "hadisafa"
      }
    end

    it "should have title, url, score, external_id" do
      expect { Article.create(attrs) }.to change{ Article.count }.by(1)
    end

    it "should be valid object" do
      expect(Article.new(attrs)).to be_valid
    end

    it "should stores the a jsonb object" do
      expect(Article.new(attrs).document.stringify_keys) =~ document
    end
  end
end
