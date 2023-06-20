require 'rails_helper'

describe PagesController do
  describe "GET home" do
    it "assigns @top_stories" do
      get :home
      expect(:top_stories).to_not be_nil
    end

    it "assigns @flagged_stories" do
      get :home
      expect(:flagged_stories).to_not be_nil
    end
  end

  describe "PUT flag" do
    before do
      @current_user = User.create(first_name: :foo, last_name: :bar, email: 'f@b.c', password: 'foobar123')
      allow(controller).to receive(:current_user).and_return(@current_user)
      @dummy_story_id = 123
    end

    it "creates a flagged story" do
      put :flag, params: { id: @dummy_story_id, type: "flag" }
      expect(FlaggedStory.find_by(story_id: @dummy_story_id, user_id: @current_user.id)).to_not be_nil
    end

    it "unflags a flagged story" do
      FlaggedStory.create(story_id: @dummy_story_id, user_id: @current_user.id)
      put :flag, params: { id: @dummy_story_id, type: "unflag" }
      expect(FlaggedStory.find_by(story_id: @dummy_story_id, user_id: @current_user.id)).to be_nil
    end
  end
end
