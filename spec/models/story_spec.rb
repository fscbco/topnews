require 'rails_helper'

RSpec.describe Story, type: :model do
  it { should have_many(:starred_stories).dependent(:destroy) }
  # Add more tests for Story validations, associations, and methods as needed
end
