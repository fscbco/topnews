require 'rails_helper'

RSpec.describe "UserArticles", type: :request do
  describe "GET /index" do
    context 'without sign in user' do
      it "returns http redirects" do
        get "/user_articles"

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
      let(:user1) { create(:user) }
      let(:articles) { create_list(:article, 3) }
      let(:article) { articles.last }
      let(:article1) { articles.first}
      let(:article2) { articles.second}
      let!(:no_user_article) { create(:article) }

      before do
        create(:user_article, user: user1, article: article1)
        create(:user_article, user: user1, article: article2)
        create(:user_article, user: current_user, article: article)
      end

      it "returns http success" do
        get "/user_articles"
        expect(response).to have_http_status(:success)
      end

      it "renders user_articles" do
        get "/user_articles"

        expect(response).to have_http_status(:success)
        expect(response.body).to include("Team Articles")
        expect(response.body).to include(article.score.to_s)
        expect(response.body).to include(article.title)
        expect(response.body).to include(article.url)

        expect(response.body).to include(current_user.first_name)
        expect(response.body).to include(current_user.last_name)

        expect(response.body).to include(article1.score.to_s)
        expect(response.body).to include(article1.title)
        expect(response.body).to include(article1.url)

        expect(response.body).to include(article2.score.to_s)
        expect(response.body).to include(article2.title)
        expect(response.body).to include(article2.url)

        expect(response.body).to include(user1.first_name)
        expect(response.body).to include(user1.last_name)

        expect(response.body).not_to include(no_user_article.score.to_s)
        expect(response.body).not_to include(no_user_article.title)
        expect(response.body).not_to include(no_user_article.url)
      end
    end
  end

  describe "POST /create" do
    context 'with sign in user' do
      include_context "signed in user"
      let(:article_attr) { attributes_for(:article) }

      it "returns http created" do
        post "/user_articles", params: { article: article_attr.as_json }
        expect(response).to have_http_status(:created)
      end

      it "creates article and user_article if they doesnt exists from params" do
        expect do
          post "/user_articles", params: { article: article_attr.as_json }
        end.to change { Article.count }.by(1)
          .and change { UserArticle.count }.by(1)
        expect(response).to have_http_status(:created)
      end

      context "with existing models" do
        it "creates only the user_article if article already exists" do
          article = create(:article, article_attr)

          expect do
            post "/user_articles", params: { article: article_attr.as_json }
          end.to change { Article.count }.by(0)
            .and change { UserArticle.count }.by(1)
          expect(response).to have_http_status(:created)
        end

        it "does not creates anything if article and user_article already exists" do
          article = create(:article, article_attr)
          user_article = create(:user_article, user: current_user, article: article)
          expect do
            post "/user_articles", params: { article: article_attr.as_json }
          end.to change { Article.count }.by(0)
            .and change { UserArticle.count }.by(0)
          expect(response).to have_http_status(:created)
        end
      end
    end
  end
end
