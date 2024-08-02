require "rails_helper"

describe LikeRepo do
  let(:user_attrs) do
    {first_name: :foo, last_name: :bar, email: "f@b.c", password: "foobar123"}
  end

  let(:user_a) {
    User.create(
      **user_attrs, email: "a@example.com", first_name: "user", last_name: "ayy"
    )
  }
  let(:user_b) {
    User.create(
      **user_attrs, email: "b@example.com", first_name: "user", last_name: "bee"
    )
  }
  let(:user_c) {
    User.create(
      **user_attrs, email: "c@example.com", first_name: "user", last_name: "see"
    )
  }

  let(:repo) { described_class.new(user_a.id) }

  describe "#toggle_like" do
    let(:story_id) { 999 }

    it "should flip from liked to unliked and back on subsequent calls" do
      expect(described_class.fetch_likes(story_id)).to match_array []

      repo.toggle_like(story_id)
      expect(described_class.fetch_likes(story_id)).to match_array [
        {
          user_id: user_a.id,
          name: "user ayy",
          story_id: story_id
        }
      ]

      repo.toggle_like(story_id)
      expect(described_class.fetch_likes(story_id)).to match_array []

      repo.toggle_like(story_id)
      expect(described_class.fetch_likes(story_id)).to match_array [
        {
          user_id: user_a.id,
          name: "user ayy",
          story_id: story_id
        }
      ]
    end

    context "with multiple likers" do
      it "should show multiple names" do
        LikeRepo.new(user_a.id).toggle_like(story_id)
        LikeRepo.new(user_b.id).toggle_like(story_id)

        expect(LikeRepo.fetch_likes(story_id)).to match_array [
          {
            user_id: user_a.id,
            name: "user ayy",
            story_id: story_id
          },
          {
            user_id: user_b.id,
            name: "user bee",
            story_id: story_id
          }
        ]
      end
    end
  end

  describe ".fetch_grouped_likes" do
    it "should return a return a hash keyed by story_id" do
      LikeRepo.new(user_a.id)
        .toggle_like(100)
        .toggle_like(200)

      LikeRepo.new(user_b.id)
        .toggle_like(200)
        .toggle_like(300)

      # shouldn't be found
      LikeRepo.new(user_c.id)
        .toggle_like(500)

      expect(LikeRepo.fetch_grouped_likes(
        [100, 200, 300, 400]
      )).to include(
        100 => "user ayy",
        200 => "user ayy, user bee",
        300 => "user bee"
      )
    end

    it "will return all likes if not given any story_ids" do
      LikeRepo.new(user_a.id)
        .toggle_like(100)
        .toggle_like(200)

      LikeRepo.new(user_b.id)
        .toggle_like(200)
        .toggle_like(300)

      # should be found
      LikeRepo.new(user_c.id)
        .toggle_like(500)

      expect(LikeRepo.fetch_grouped_likes)
        .to include(
          100 => "user ayy",
          200 => "user bee, user ayy",
          300 => "user bee",
          500 => "user see"
        )
    end
  end
end
