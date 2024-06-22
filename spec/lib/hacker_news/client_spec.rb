# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

describe HackerNews::Client, type: :lib do
  let :api do
    described_class.new
  end
  
  describe "#top_stories" do
    before do
      # This is some kind of double-dipping here:
      # once I decided not to return a list of IDs for `top_stories`,
      # stubbing the request broke since I was making multiple requests.
      # So, here I stub the first of these requests to limit the number of stories
      # returned then let VCR interrupt and mimic the additional requests per story.
      # Ideally, you only want one of these two but HN defaults to 500 stories!!!
      stub_request( :get, url )
      .with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "Content-Type"=>"application/json",
          "Host"=>"hacker-news.firebaseio.com",
          "User-Agent"=>"Ruby"
        },
      )
      .to_return( status: 200, body: [ 123, 456 ].to_json, headers: { "Content-Type" => "application/json" } )
    end

    let :url do
      "https://hacker-news.firebaseio.com/v0/topstories.json"
    end

    it "gets the list of top stories IDs", :vcr do
      response = api.top_stories

      expect( response ).to contain_exactly(
        an_object_having_attributes( id: 123, type: "story", score: 8, by: "beau" ),
        an_object_having_attributes( id: 456, type: "comment", parent: 363, by: "staunch" ),
      )
    end
  end

  describe "#story" do
    let :mocked_response do
      {
        by: "hsanchez",
        descendants: 321,
        id: 123,
        kids: [ 8934, 8943, 8876 ],
        score: 104,
        title: "Silly title",
        type: "story",
        url: "http://www.google.com",
      }
    end
    
    let :url do
      "https://hacker-news.firebaseio.com/v0/item/#{ story_id }.json"
    end

    context "when the id is valid" do
      before do
        stub_request( :get, url )
        .with(
          headers: {
            "Accept"=>"*/*",
            "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Content-Type"=>"application/json",
            "Host"=>"hacker-news.firebaseio.com",
            "User-Agent"=>"Ruby"
          },
          )
          .to_return( status: 200, body: mocked_response.to_json, headers: { "Content-Type" => "application/json" } )
      end
      
      let( :story_id ) { 123 }

      it "gets the story for the given id" do
        response = api.story( story_id )

        expect( response ).to have_attributes(
          by: "hsanchez",
          descendants: 321,
          id: 123,
          kids: match_array( [ 8934, 8943, 8876 ] ),
          score: 104,
          title: "Silly title",
          type: "story",
          url: "http://www.google.com",
        )
      end
    end

    context "when the id is invalid" do
      before do
        stub_request( :get, url )
        .with(
          headers: {
            "Accept"=>"*/*",
            "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
            "Content-Type"=>"application/json",
            "Host"=>"hacker-news.firebaseio.com",
            "User-Agent"=>"Ruby"
          },
          )
          .to_return( status: 200, body: "".to_json, headers: { "Content-Type" => "application/json" } )
      end
  
      let( :story_id ) { -1 }

      it "returns an empty result for the given id" do
        response = api.story( story_id )

        expect( response ).to be_nil
      end
    end
  end
end
