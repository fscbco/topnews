require 'rails_helper'

describe Starrable do
  it "belongs to a story" do
    reflection = Starrable.reflect_on_association(:story)
    expect(reflection.macro).to eq(:belongs_to)
  end

  it "belongs to a user" do
    reflection = Starrable.reflect_on_association(:user)
    expect(reflection.macro).to eq(:belongs_to)
  end
end
