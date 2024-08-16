require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /index" do
    context 'without sign in user' do
      it "returns http redirects" do
        get "/articles"

        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(:new_user_session)

        follow_redirect!

        expect(response.body).to include("You need to sign in or sign up before continuing")
        expect(response.body).to include("Log in")
        expect(response.body).to include("Email")
        expect(response.body).to include("Password")
        expect(response.body).to include("Remember me")
      end
    end

    context 'with sign in user' do
      include_context "signed in user"

      let(:mock_story) do
        {
          "id"=>41247023,
          "kids"=>[41247704, 41247268],
          "descendants"=>496,
          "title"=>"Show HN: If YouTube had actual channels",
          "url"=>"https://ytch.xyz",
          "type"=>"story",
          "score"=>2554,
          "time"=>1723648206,
          "by"=>"hadisafa"
        }
      end

      it "returns http success" do
        get "/articles"
        expect(response).to have_http_status(:success)
      end

      it "renders articles and stories" do
        mock_topstories_ids = [41247023,41248104,41247982]
        mock_hacker_news = double('HackerNews', topstories: mock_topstories_ids, item: mock_story)
        allow(HackerNews).to receive(:new).and_return(mock_hacker_news)
        article = create(:article, external_id: mock_topstories_ids.last)

        get "/articles"
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Articles TOP Feed")
        expect(response.body).to include(article.score.to_s)
        expect(response.body).to include(article.title)
        expect(response.body).to include(article.url)
        expect(response.body).to include(mock_story["score"].to_s)
        expect(response.body).to include(mock_story["title"])
        expect(response.body).to include(mock_story["url"])
      end
    end
  end
end
