require 'rails_helper'


RSpec.describe HackerNews::GetStoryIds do
  subject(:service) { described_class.new }
    
  describe '#call' do
    context 'when service is called' do
      it 'gets storu ids' do
        result = service.call
        
        expect(result.success?).to be true
        
      end
    end


  end


  

end