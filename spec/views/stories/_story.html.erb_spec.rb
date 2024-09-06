require 'rails_helper'

RSpec.describe 'stories/_story', type: :view do
  let(:story) { { title: 'Test Story', url: 'https://example.com', id: 1 } }
  let(:user) { create(:user) }

  before do
    assign(:story, story)
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
    allow(view).to receive(:story_starred_by_users).and_return([user])
  end

  it 'displays the story title and link' do
    render partial: 'stories/story', locals: { story: story, id: story[:id] }

    expect(rendered).to have_link('Test Story', href: 'https://example.com')
  end

  it 'displays users who starred the story if any' do
    render partial: 'stories/story', locals: { story: story, id: story[:id] }

    expect(rendered).to have_content('Starred by:')
    expect(rendered).to have_content('John Doe')
  end
end