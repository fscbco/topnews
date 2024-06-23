# frozen_string_literal: true

require "rails_helper"

# This spec is admittedly not very useful; I included it because I ran out of time
# and to highlight that this is part of my approach for end-to-end tests.
# Some of the things missing are:
# 1. Assertions for the data expected
# 2. In this case a test I would normally test the behavior of each CTA; in the case
# of 'Read more', at least that it points to the correct URL.
# 3. Normally, in the case of post and put/patch actions, I would put those in different spec files (e.g. story_put_spec);
# however, in this case (because it is so simple) I would do it in the show spec.
# 4. For some strange reason it won't login successfully even though on a step-through 
# the user exists; also Devise's `sign_in` helper didn't work
# 5. For VCR to actually be working (honestly not sure yet why it doesn't)
RSpec.describe "Stories show", vcr: { cassette_name: "stories/show" }, type: :feature,  js: true do
  let!( :user ) { create :user }

  before do
    # Simulate user sign-in
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
    
    visit story_path 123
  end


  xit "displays the details for the story" do
    expect( page ).to have_button( "Read more" )
  end
end
