require 'rails_helper'

RSpec.describe "stories/index.html.erb", type: :view do
  before do
    @user = FactoryBot.create(:user, first_name: 'Sarah', last_name: 'Duve', email: 'sarah@example.com', password: 'password')
    @users = FactoryBot.create_list(:user, 3)
    @other_user = @users.first()
    @story1 = FactoryBot.create(:story, title: "#{@other_user.first_name} thought this was interesting", users: [@other_user])
    assign(:interesting_stories, [@story1])
    assign(:stories, [@story1])
  end

  it "shows interesting stories and who recommended them" do
    render template: "stories/index"
    puts rendered
    expect(rendered).to match(@story1.title)
    expect(rendered).to match("marked by #{ @other_user.first_name }")
  end
end
