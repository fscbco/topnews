require 'rails_helper'

RSpec.describe PostAuthor, type: :model do
  it { should have_many(:posts) }
end
