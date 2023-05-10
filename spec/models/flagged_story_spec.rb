require 'rails_helper'

RSpec.describe FlaggedStory, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:story) }
end
