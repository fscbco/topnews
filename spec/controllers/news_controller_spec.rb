require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  let(:user) { User.create(email: 'test@test.com', password: 'password') }
  let(:story) { Story.create(external_id: 1, title: 'A sample story', url: 'http://example.com') }

  before do
    sign_in user
  end

  describe "GET #index" do
    before do
      allow(Net::HTTP).to receive(:get) do |uri|
        if uri.to_s == "https://hacker-news.firebaseio.com/v0/topstories.json"
          [1, 2, 3, 4, 5].to_json
        else
          { 'id' => 1, 'title' => 'A sample story', 'url' => 'http://example.com' }.to_json
        end
      end      
    end

    it "fetches top stories from Hacker news" do
      get :index
      stories = controller.instance_variable_get(:@stories)
      expect(stories).to_not be_empty
    end
  end
end