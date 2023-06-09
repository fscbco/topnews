require 'rails_helper'

RSpec.describe "likes/edit", type: :view do
  before(:each) do
    @like = assign(:like, Like.create!(
      story_id: nil,
      user_id: nil
    ))
  end

  it "renders the edit like form" do
    render

    assert_select "form[action=?][method=?]", like_path(@like), "post" do

      assert_select "input[name=?]", "like[story_id_id]"

      assert_select "input[name=?]", "like[user_id_id]"
    end
  end
end
