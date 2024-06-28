# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  let(:story) { create(:story) }

  describe 'associations' do
    it 'has many likes' do
      association = described_class.reflect_on_association(:likes)
      expect(association.macro).to eq :has_many
    end

    it 'has many users through likes' do
      association = described_class.reflect_on_association(:users)
      expect(association.macro).to eq :has_many
      expect(association.options[:through]).to eq :likes
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(story).to be_valid
    end

    it 'is not valid without a hacker_news_id' do
      story.hacker_news_id = nil
      expect(story).not_to be_valid
      expect(story.errors[:hacker_news_id]).to include("can't be blank")
    end

    it 'is not valid without a unique hacker_news_id' do
      Story.create!(hacker_news_id: 1, author: 'Author', time: Time.now, title: 'Title', url: 'http://example.com')
      new_story = Story.new(hacker_news_id: 1, author: 'Author', time: Time.now, title: 'Title', url: 'http://example.com')
      expect(new_story).not_to be_valid
      expect(new_story.errors[:hacker_news_id]).to include("has already been taken")
    end

    it 'is not valid without an author' do
      story.author = nil
      expect(story).not_to be_valid
      expect(story.errors[:author]).to include("can't be blank")
    end

    it 'is not valid without a time' do
      story.time = nil
      expect(story).not_to be_valid
      expect(story.errors[:time]).to include("can't be blank")
    end

    it 'is not valid without a title' do
      story.title = nil
      expect(story).not_to be_valid
      expect(story.errors[:title]).to include("can't be blank")
    end

    it 'is not valid without a url' do
      story.url = nil
      expect(story).not_to be_valid
      expect(story.errors[:url]).to include("can't be blank")
    end
  end
end
