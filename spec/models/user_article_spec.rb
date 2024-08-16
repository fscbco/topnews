require 'rails_helper'

describe UserArticle do
  context 'creating a new user_articles' do
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    let(:attrs) do
      {
        user: user,
        article: article
      }
    end

    it "should create the user article based on those two models" do
      expect { UserArticle.create(attrs) }.to change{ UserArticle.count }.by(1)
    end
  end
end
