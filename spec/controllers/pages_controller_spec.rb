require 'rails_helper'

RSpec.describe PagesController, type: :request do
    describe 'GET #home' do
        subject { get root_path }
        before do
            stub_request(:get, "#{HackerNewsApi::BASE_URL}/v0/topstories.json")
                .with(headers: {
                    'Accept'=>'application/json',
                    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                    'User-Agent'=>'Ruby'
                })
                .to_return(status: 200, body: "", headers: {})
        end

        it 'renders the home page' do
            subject

            expect(response).to render_template(root_path)
            expect(response).to be_successful
        end 
    end

    describe 'GET #interesting_stories' do
        subject { get interesting_stories_path }

        it 'renders the home page with correct data' do
            subject

            expect(response).to render_template(root_path)
            expect(response).to be_successful
        end 
        
    end
end