require 'rails_helper'

RSpec.describe HackerNews::CreateItemDetail do
  subject(:service) {described_class}


  describe '#call' do
    context 'creates new NewsDetail from HN story ID' do

      it 'saves new news detail' do
        result = service.new(41234585).call

        expect(result.success?).to be true
      end

      it 'does not save duplicates' do
        service.new(41234585).call
        result = service.new(41234585).call
        expect(result.success?).to be false
      end

      it 'does not save invalid data' do
        result = service.new(4123458599999).call
        expect(result.success?).to be false
      end
    end

  end
end