require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:post_author) }
  it { should have_many(:favorites) }
  it { should have_many(:users).through(:favorites) }
  it { should define_enum_for(:post_type) }
end
