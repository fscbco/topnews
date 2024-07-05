# frozen_string_literal: true

require "rails_helper"

describe Story, type: :model do
  describe "#flagged_by" do
  subject :flagged_by do
    story.users
  end  
  
  let :story do
    create( :story, by: "hsanchez", id: 123 )
  end

    it { is_expected.to be_empty }

    context "when the story has been flagged" do
      before do
        create( :flagged_story, story_id: story.id, user: hector )
        create( :flagged_story, story_id: story.id, user: mike )
      end

      let :hector do
        create( :user, first_name: "Hector", password: "dsderu3o32!", email: "hector@example.com" )
      end

      let :mike do
        create( :user, first_name: "Mike", password: "1243dsfcscx~", email: "mike@example.com" )
      end

      it "gets the users who flagged this story" do
        expect( flagged_by ).to contain_exactly(
          an_object_having_attributes( id: hector.id, first_name: hector.first_name ),
          an_object_having_attributes( id: mike.id, first_name: mike.first_name ),
        )
      end
    end
  end

  describe "#flag!" do
    subject :flag do
      story.flag!( user: hector )
    end

    let :hector do
      create( :user )
    end

    let :story do
      create( :story, by: "hsanchez", id: 456 )
    end
  
    context "when the story has not been flagged by the user" do
      it "creates a FlaggedStory" do
        expect { flag }.to change { FlaggedStory.count }.by( 1 )
      end
    end

    context "when the story has previously been flagged by the user" do
      before do
        create( :flagged_story, story_id: story.id, user: hector )
      end

      it "does not create a FlaggedStory" do
        expect { flag }.not_to change { FlaggedStory.count }
      end
    end
  end
end
