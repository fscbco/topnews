require 'rails_helper'

describe Story do
  context "creating a new story" do

    let(:attrs) do
      { hn_story_id:SecureRandom.random_number(8), 
        title: "Test Title" , 
        time: '2023-05-03T04:05:06+00:00',
        by: "Test Author", 
        url: "wwww.google.come"  }
    end

    it "should create record" do
      expect { Story.create(attrs) }.to change{ Story.count }.by(1)
    end
  end
end
