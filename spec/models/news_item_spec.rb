require 'rails_helper'

RSpec.describe NewsItem, type: :model do

  context "creating a new news_item" do
    let(:attrs) do
      { hacker_news_id: 322222, url: 'url_for_news', title: 'TestTitle', item_type: 'article' }
    end

    it "should have hacker_news_id, url, title, and item_type" do
      expect { NewsItem.create(attrs) }.to change{ NewsItem.count }.by(1)
    end
  end
end
