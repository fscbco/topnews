require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET #home" do
    it "assigns @page_count with default value" do
      get :home
      expect(assigns(:page_count)).to eq(1)
    end

    it "assigns @page_count with provided value" do
      get :home, params: { page_count: 2 }
      expect(assigns(:page_count)).to eq(2)
    end

    it "assigns @feed with a valid feed" do
      yc_connector_mock = instance_double("YcConnector")
      allow(YcConnector).to receive(:new).and_return(yc_connector_mock)
      allow(yc_connector_mock).to receive(:build_feed).and_return("mocked_feed")

      get :home
      expect(assigns(:feed)).to eq("mocked_feed")
    end

    it "assigns @liked_feed with a list of posts" do
      post1 = create(:post)
      post2 = create(:post)
      get :home
      expect(assigns(:liked_feed)).to eq([post2, post1])
    end

    it "renders the home template" do
      get :home
      expect(response).to render_template(:home)
    end
  end
end