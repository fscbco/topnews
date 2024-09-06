require 'rails_helper'

RSpec.describe 'stories/index', type: :view do
  let(:stories) { [{ title: 'Story 1', url: 'https://example.com/1', id: 1 }, { title: 'Story 2', url: 'https://example.com/2', id: 2 }] }
  let(:starred_stories) { [{ title: 'Starred Story', url: 'https://example.com/starred', hacker_news_id: 3 }] }
  let(:user) { create(:user) }

  before do
    assign(:stories, stories)
    assign(:current_user_starred_stories, starred_stories)
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(user)
  end

  it 'displays the top stories section' do
    render

    expect(rendered).to have_content('Top Hacker News Stories')
    expect(rendered).to have_link('Story 1', href: 'https://example.com/1')
    expect(rendered).to have_link('Story 2', href: 'https://example.com/2')
  end

  it 'displays the starred stories section if the user has starred stories' do
    render

    expect(rendered).to have_content('Your Starred Stories')
    expect(rendered).to have_link('Starred Story', href: 'https://example.com/starred')
  end

  it 'does not display the starred stories section if there are no starred stories' do
    assign(:current_user_starred_stories, [])

    render

    expect(rendered).not_to have_content('Your Starred Stories')
  end
end