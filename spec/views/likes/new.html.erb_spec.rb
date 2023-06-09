require 'rails_helper'

RSpec.describe "likes/new", type: :view do
  before(:each) do
    assign(:like, Like.new(
      story_id: nil,
      user_id: nil
    ))
  end

  it "renders new like form" do
    render

    assert_select "form[action=?][method=?]", likes_path, "post" do

      assert_select "input[name=?]", "like[story_id_id]"

      assert_select "input[name=?]", "like[user_id_id]"
    end
  end
end
