require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe '#home' do
    it 'renders the home template' do
      get :home
      expect(response).to render_template(:home)
    end

    it 'assigns the top stories to @stories' do
      stories = create_list(:story, 5)
      allow_any_instance_of(HackerNewsService).to receive(:top_stories).and_return(stories)
      
      get :home
      expect(assigns(:stories)).to eq(stories)
    end
  end
end
