require 'rails_helper'

RSpec.describe "Stories", type: :request do
  let(:user) { User.create(email: "ari@me.com", password: 123456) }
  let!(:first_story) { Story.create(story_id: "first_story", title: "first_story") }
  let!(:second_story) { Story.create(story_id: "second_story", title: "second_story") }
  let!(:third_story) { Story.create(story_id: "third_story", title: "third_story") }

  before { sign_in user }

  describe "GET /home" do
    # TODO: might make sense to put this in a shared context
    let(:story_id) { 36824181 }
    let(:story_ids) { (["first_story", "second_story", "third_story"] + [story_id]).to_json }
    let(:good_response) do
      {
        "id": story_id,
        "by": "keepamovin",
        "descendants": 2,
        "kids": [
          36848942,
          36849331
        ],
        "score": 9,
        "time": 1690011007,
        "title": "A Heap O' Livin'",
        "type": "story",
        "url": "https://www.buckleyschool.com/magazine/articles/poem-to-read-aloud-a-heap-o-livin/"
      }.to_json
    end

    
    context "with a good request" do
      before do      
        # Request for story ids
        expect(Net::HTTP).to receive(:get).with(URI(StoriesController::HACKER_NEWS_TOP_STORIES_URL)) { story_ids }
    
        # Request for story details
        expect(Net::HTTP).to receive(:get).with(URI("#{StoriesController::HACKER_NEWS_GET_STORY_URL}#{story_id}.json")) { good_response }
      end

      it "returns the stories it has displays it" do
        get "/"
  
        expect(response).to be_successful
        expect(response.body).to include("first_story")
        expect(response.body).to include("second_story")
        expect(response.body).to include("third_story")
        expect(response.body).to include("keepamovin")
      end

      it "creates the story" do
        expect{ 
          get "/"
        }.to change(Story, :count).by(1)
      end
    end

    context "when the request to hacker news fails" do
      before do
        expect(Net::HTTP).to receive(:get).and_raise(Net::HTTPBadResponse)
      end

      it "returns the stories it has and shows a flash message of the error" do
        get "/"

        expect(response).to be_successful
        expect(response.body).to include("first_story")
        expect(response.body).to include("second_story")
        expect(response.body).to include("third_story")
        expect(response.body).to include("There was an error retrieving stories from Hacker News. Please try again later")
      end
    end

    context "when hacker news returns a bad response (no story_id)" do
      # TODO: might make sense to put this in a shared context

      let(:story_id) { "" }
      let(:no_story_ids) { (["first_story", "second_story", "third_story"] + [story_id]).to_json }
      let(:no_story_id_response) do
        {
          "id": story_id,
          "by": "keepamovin",
          "descendants": 2,
          "kids": [
            36848942,
            36849331
          ],
          "score": 9,
          "time": 1690011007,
          "title": "A Heap O' Livin'",
          "type": "story",
          "url": "https://www.buckleyschool.com/magazine/articles/poem-to-read-aloud-a-heap-o-livin/"
        }.to_json
      end

      before do
        # Request for story ids
        expect(Net::HTTP).to receive(:get).with(URI(StoriesController::HACKER_NEWS_TOP_STORIES_URL)) { no_story_ids }

        # Request for story details
        expect(Net::HTTP).to receive(:get).with(URI("#{StoriesController::HACKER_NEWS_GET_STORY_URL}#{story_id}.json")) { no_story_id_response }
      end

      it "returns the stories it has and shows a flash message of the error" do
        get "/"

        expect(response).to be_successful
        expect(response.body).to include("first_story")
        expect(response.body).to include("second_story")
        expect(response.body).to include("third_story")
        expect(response.body).to include("Validation failed")
      end
    end
  end

  describe "GET /starred" do
    let!(:star_1) { Starrable.create(user: user, story: first_story) }
    let!(:star_2) { Starrable.create(user: user, story: third_story) }

    it "returns only the starred stories" do
      get "/starred"
      expect(response).to be_successful
      expect(response.body).to include("first_story")
      expect(response.body).to_not include("second_story")
      expect(response.body).to include("third_story")
    end
  end
end
