require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      title: "MyString",
      user: "MyString",
      up_vote: 1
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input[name=?]", "post[title]"

      assert_select "input[name=?]", "post[user]"

      assert_select "input[name=?]", "post[up_vote]"
    end
  end
end
