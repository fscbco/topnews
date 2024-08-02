# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  story_id   :integer
#  user_id    :bigint
#
# Indexes
#
#  index_likes_on_user_id               (user_id)
#  index_likes_on_user_id_and_story_id  (user_id,story_id) UNIQUE
#
require "rails_helper"

describe Like do
  describe "#user_name" do
    let(:user) { User.new(first_name: "foo", last_name: "bar") }

    it "should be constructed from the liker's first/last name" do
      like = Like.new({
        user: user,
        story_id: 9999
      })
      expect(like.user_name).to eq "foo bar"
    end
  end
end
