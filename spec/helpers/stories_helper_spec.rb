require 'rails_helper'

RSpec.describe StoriesHelper, type: :helper do
  let(:story) { create(:story, hacker_news_id: 1) }
  let(:user) { create(:user) } 

  before do
    # Setting up the association between story and users
    story.starred_by_users << user
  end

  describe 'Story is in database' do
    context 'when the story exists in the database' do
      it 'returns true' do
        expect(helper.story_in_database?(story.hacker_news_id)).to be(true)
      end
    end

    context 'when the story does not exist in the database' do
      it 'returns false' do
        expect(helper.story_in_database?(999)).to be(false)
      end
    end
  end

  describe 'Story starred by users' do
    context 'when the story exists and has users who starred it' do
      it 'returns the users who starred the story' do
        expect(helper.story_starred_by_users(story.hacker_news_id)).to include(user)
      end
    end

    context 'when the story does not exist' do
      it 'returns nil' do
        expect(helper.story_starred_by_users(999)).to be_nil
      end
    end
  end
end