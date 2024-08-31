require 'rails_helper'

describe FlaggedStory, type: :model do
  context 'Attributes' do
    it { expect(subject).to have_db_column(:title).of_type(:string) }
    it { expect(subject).to have_db_column(:url).of_type(:string) }
    it { expect(subject).to have_db_column(:created_at).of_type(:datetime) }
    it { expect(subject).to have_db_column(:updated_at).of_type(:datetime) }
  end

  context 'Validations' do
    it { expect(subject).to validate_presence_of(:title) }
    it { expect(subject).to validate_presence_of(:url) }
  end

  context 'Associations' do
    describe 'HABTM' do
      it { should have_and_belong_to_many(:users).validate(true) }
    end
  end
end
