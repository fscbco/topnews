require 'rails_helper'

RSpec.describe StarredStory, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:story) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:story_id) }
end
