# frozen_string_literal: true

require "rails_helper"
require "webmock/rspec"

describe HackerNews::Client, type: :lib do
  let :api do
    described_class.new
  end
  
  describe "#top_stories" do
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
      .to_return( status: 200, body: [ 123, 456 ].to_json, headers: { "Content-Type" => "application/json" } )
    end

    let :url do
      "https://hacker-news.firebaseio.com/v0/topstories.json"
    end

    it "gets the list of top stories IDs" do
      response = api.top_stories

      expect( response ).to match_array( [ 123, 456 ] )
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
          story_type: "story",
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
