require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      title: "MyString",
      user: "MyString",
      up_vote: 1
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input[name=?]", "post[title]"

      assert_select "input[name=?]", "post[user]"

      assert_select "input[name=?]", "post[up_vote]"
    end
  end
end
