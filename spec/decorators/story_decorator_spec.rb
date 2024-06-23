# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoryDecorator do
  let :story do
    Story.new(
      {
        by: "hsanchez",
        descendants: 321,
        id: 123,
        kids: [ 8934, 8943, 8876 ],
        score: 104,
        title: "Silly title",
        type: "story",
        url: "http://www.google.com",
        time: 1719060558,
      }
    )
  end

  let :decorator do
    StoryDecorator.new story
  end

  describe "#created_on" do
    subject :created_on do
      decorator.created_on
    end

    it { is_expected.to eq Date.parse( "2024-06-22" ) }
  end

  describe "#flagged_by" do
    subject :flagged_by do
      decorator.flagged_by
    end

    it { is_expected.to eq( "" ) }

    context "when the story has been flagged" do
      before do
        FactoryBot.create :flagged_story, user: mike, story_id: story.id
        FactoryBot.create :flagged_story, user: rosa, story_id: story.id
      end
    
      let :mike do
        FactoryBot.create :user, first_name: "Mike"
      end
      
      let :rosa do
        FactoryBot.create :user, first_name: "Rosa"
      end

      it { is_expected.to eq( "Mike and Rosa" ) }
    end
  end


  describe "#flagged_count" do
    subject :flagged_count do
      decorator.flagged_count
    end

    it { is_expected.to eq( 0 ) }

    context "when the story has been flagged" do
      before do
        FactoryBot.create :flagged_story, user: mike, story_id: story.id
        FactoryBot.create :flagged_story, user: rosa, story_id: story.id
      end
    
      let :mike do
        FactoryBot.create :user, first_name: "Mike"
      end
      
      let :rosa do
        FactoryBot.create :user, first_name: "Rosa"
      end

      it { is_expected.to eq( 2 ) }
    end
  end
end
