require 'rails_helper'

describe User do
  context 'Attributes' do
    it { expect(subject).to have_db_column(:first_name).of_type(:string) }
    it { expect(subject).to have_db_column(:last_name).of_type(:string) }
    it { expect(subject).to have_db_column(:email).of_type(:string) }
    it { expect(subject).to have_db_column(:encrypted_password).of_type(:string) }
    it { expect(subject).to respond_to(:password) }
  end

  context 'Validations' do
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(subject).to validate_presence_of(:first_name) }
    it { expect(subject).to validate_presence_of(:last_name) }
  end

  context 'Methods' do
    context '# Instance' do
      describe '.full_name' do
        it 'concatenates :first_name & :last_name' do
          user = build(:user, first_name: 'Bob', last_name: 'Jones')
          expect(user.full_name).to eq('Bob Jones')
        end
      end
    end
  end

  context 'Associations' do
    describe 'HABTM' do
      it { should have_and_belong_to_many(:flagged_stories).validate(true) }
    end
  end

  context 'Lifecycle' do
    describe 'creation' do
      let(:attrs) do
        { first_name: :foo, last_name: :bar, email: 'f@b.c', password: 'foobar123' }
      end
    
      it "should require a password" do
        expect(User.new(attrs.except(:password))).to be_invalid
      end
    end
  end
  
end
