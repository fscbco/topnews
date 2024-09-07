require 'rails_helper'

RSpec.describe 'stories/_star_button', type: :view do
  let(:story) { { title: 'Test Story', url: 'https://example.com', id: 1 } }
  let(:user) { create(:user) }

  context 'when the user is signed in' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(true)
      allow(view).to receive(:current_user).and_return(user)
    end

    it 'renders the unstar button if the story is already starred' do
      allow(user).to receive_message_chain(:starred_stories, :exists?).with(hacker_news_id: 1).and_return(true)

      render partial: 'stories/star_button', locals: { story: story, id: story[:id] }

      expect(rendered).to have_selector('.unstar-btn')
    end

    it 'renders the star button if the story is not starred' do
      allow(user).to receive_message_chain(:starred_stories, :exists?).with(hacker_news_id: 1).and_return(false)

      render partial: 'stories/star_button', locals: { story: story, id: story[:id] }
      expect(rendered).to have_selector('.star-btn')
    end
  end

  context 'when the user is not signed in' do
    before do
      allow(view).to receive(:user_signed_in?).and_return(false)
    end

    it 'renders a button to sign in' do
      render partial: 'stories/star_button', locals: { story: story, id: story[:id] }

      expect(rendered).to have_selector('.logged-out-star-btn')
    end
  end
end