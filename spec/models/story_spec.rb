require 'rails_helper'

RSpec.describe Story, type: :model do
  it { should have_many(:starred_stories).dependent(:destroy) }
  # Add more tests for Story validations, associations, and methods as needed
end

RSpec.describe StarredStory, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:story) }
  # Add more tests for StarredStory validations, associations, and methods as needed
end

