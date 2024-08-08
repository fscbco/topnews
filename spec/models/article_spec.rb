require 'rails_helper'

RSpec.describe Article, type: :model do

  it "is valid with valid attributes" do
    expect(
      Article.new(
        article_id: 1,
        author: "John Doe",
        title: "Test Title",
        url: "http://kasheesh.com"
      )
    ).to be_valid
  end
  
  it "is invalid without valid article_id" do
    expect(
      Article.new(
        article_id: nil,
        author: "John Doe",
        title: "Test Title",
        url: "http://kasheesh.com"
      )
    ).to_not be_valid
  end
  
  it "is invalid without author" do
    expect(
      Article.new(
        article_id: 1,
        author: "",
        title: "Test Title",
        url: "http://kasheesh.com"
      )
    ).to_not be_valid
  end
  
  it "is invalid without title" do
    expect(
      Article.new(
        article_id: 1,
        author: "John Doe",
        title: "",
        url: "http://kasheesh.com"
      )
    ).to_not be_valid
  end
  
  it "is invalid without url" do
    expect(
      Article.new(
        article_id: 1,
        author: "John Doe",
        title: "Test Title",
        url: ""
      )
    ).to_not be_valid
  end
  
end
