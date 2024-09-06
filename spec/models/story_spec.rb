require 'rails_helper'

RSpec.describe Story, type: :model do
  describe 'associations' do
    it 'has many stars with dependent destroy' do
      story = Story.create(hacker_news_id: 1, title: 'Sample Title', url: 'http://example.com')
      star = Star.create(story: story, user: User.create(email: 'test@example.com', password: 'password'))

      expect(story.stars).to include(star)

      # Test dependent destroy
      expect { story.destroy }.to change { Star.count }.by(-1)
    end

    it 'has many starred_by_users through stars' do
      user = User.create(email: 'test2@example.com', password: 'password')
      story = Story.create(hacker_news_id: 2, title: 'Another Title', url: 'http://example.com')
      Star.create(story: story, user: user)

      expect(story.starred_by_users).to include(user)
    end
  end

  describe 'validations' do
    it 'is invalid without a hacker_news_id' do
      story = Story.new(title: 'No ID', url: 'http://example.com')
      expect(story.valid?).to be false
      expect(story.errors[:hacker_news_id]).to include("can't be blank")
    end

    it 'is invalid without a title' do
      story = Story.new(hacker_news_id: 3, url: 'http://example.com')
      expect(story.valid?).to be false
      expect(story.errors[:title]).to include("can't be blank")
    end

    it 'is invalid without a url' do
      story = Story.new(hacker_news_id: 4, title: 'No URL')
      expect(story.valid?).to be false
      expect(story.errors[:url]).to include("can't be blank")
    end

    it 'is invalid if hacker_news_id is not unique' do
      Story.create(hacker_news_id: 5, title: 'Unique ID', url: 'http://example.com')
      duplicate_story = Story.new(hacker_news_id: 5, title: 'Duplicate ID', url: 'http://example.com')

      expect(duplicate_story.valid?).to be false
      expect(duplicate_story.errors[:hacker_news_id]).to include('has already been taken')
    end
  end
end