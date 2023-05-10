require 'rails_helper'

RSpec.describe FetchTopStoriesJob, type: :job do
  include WebMock::API
  WebMock.enable!

  describe '.perform_now' do
    it 'fetches top stories and creates records' do
      stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json")
        .to_return(
          status: 200,
          body: [1, 2].to_json,
          headers: { 'Content-Type': 'application/json' }
        )

      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/1.json")
        .to_return(
          status: 200,
          body: { 'title' => 'Story One', 'url' => 'https://example.com/story_one' }.to_json,
          headers: { 'Content-Type': 'application/json' }
        )

      stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/2.json")
        .to_return(
          status: 200,
          body: { 'title' => 'Story Two', 'url' => 'https://example.com/story_two' }.to_json,
          headers: { 'Content-Type': 'application/json' }
        )

      expect {
        FetchTopStoriesJob.perform_now
      }.to change(Story, :count).by(2)

      story_one = Story.find_by(title: 'Story One')
      expect(story_one.url).to eq('https://example.com/story_one')

      story_two = Story.find_by(title: 'Story Two')
      expect(story_two.url).to eq('https://example.com/story_two')
    end
  end
end
