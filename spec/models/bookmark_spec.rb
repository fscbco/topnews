require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:article) }
  end

  user = User.create!(first_name: "John", last_name: "Doe", email: "john@doe.com", password: "xxxxxxxx")
  article = Article.create!(article_id: 1, author: "Author", title: "Title", url: "http://kasheesh.com/1")

  describe "creation" do
    it "creates a valid bookmark" do
      bookmark = Bookmark.create!(user_id: user.id, article_id: article.id)
      expect(bookmark).to be_valid
    end
  end
end