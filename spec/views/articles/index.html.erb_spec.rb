require 'rails_helper'

RSpec.describe "articles/index", type: :view do

  before(:each) do
    @articles = []
    5.times do
      @articles << Article.new(
        article_id: rand(1000),
        author: "Author #{rand(10000)}",
        title: "Article Title #{rand(1000)}",
        url: "http://topnews.com/article_#{rand(1000)}"
      )
    end
    @articles.each(&:save!)
  end

  it "displays a list of articles" do
    render

    expect(rendered).to match /Title/
    expect(rendered).to include("Bookmarked By")
    @articles.each do |article|
      expect(rendered).to include(article.title)
    end
  end
end