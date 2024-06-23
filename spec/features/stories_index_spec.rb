# frozen_string_literal: true

require "rails_helper"

# This spec is admittedly not very useful; I included it because I ran out of time
# and to highlight that this is part of my approach for end-to-end tests.
# Some of the things missing are:
# 1. actual row-by-row assertions for 
# 2. In this case a test for each kind of list expected (e.g. top stories and team stories)
# 3. For VCR to actually be working (honestly not sure yet why it doesn't)
RSpec.describe "Stories index", vcr: { cassette_name: "stories/index" }, type: :feature,  js: true do
  before do
    visit stories_path
  end


  it "displays all stories" do
    expect( page ).to have_content( "Top Stories" )
    expect( page ).to have_content( "Team Stories" )
  end
end
