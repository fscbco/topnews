require 'rails_helper'
require 'webmock/rspec'

RSpec.describe HackerNewsApi do
    let(:service) { described_class.new }

    describe '#new / initalize' do
        it 'is initalized with a retry count' do
            expect(service.retry_count).to eq(3)
        end
    end

    shared_examples 'a successful request' do
        it 'returns a request with data in body' do
            subject

            expect(response.code).to eq("200")
            expect(response.body).to eq(mock_response_body)
        end
    end

    shared_examples 'a failed request with code 400 to 499' do
        let(:status) { 404 }
        let(:mock_response_body) { 'not found' }
        let(:error_message) { "API request failed with code #{status}. Bad Request Error, please check request." }
        it 'logs the error' do
            expect(Rails.logger).to receive(:error).once.with(error_message)

            subject
        end
    end

    shared_examples 'a failed request with code 500 to 599' do
        let(:status) { 500 }
        let(:mock_response_body) { 'hmmm something is not right' }
        let(:error_message) { "Exceeded maximum retries. API request failed with code #{status}" }

        it 'retries the request' do
            expect(Rails.logger).to receive(:info).exactly(3).times.with("Retrying request to #{uri}.")
            expect { subject }.to change { service.retry_count }.by(-3)
            expect(subject).to eq(default_return)
        end

        context 'when retries are exhausted' do
            before do
                service.retry_count = 0
            end

            it 'logs the request as an error' do
                expect(Rails.logger).to receive(:error).once.with(error_message)

                expect(subject).to eq(default_return)
            end 
        end
    end

    describe '#get_current_stories_ids' do
        subject { service.get_current_stories_ids }
        let(:uri) { URI("#{HackerNewsApi::BASE_URL}/v0/topstories.json") }
        let(:response) { service.send(:response, uri) }
        let(:mock_response_body) { '[1, 2, 3, 4, 5]' }
        let(:status) { 200 }
        let(:default_return) { [] }

        before do
            stub_request(:get, uri)
                .with(headers: {'Accept': 'application/json'})
                .to_return(status: status, body: mock_response_body)
        end

        it 'returns the parsed array data' do
            expect(subject).to eq(JSON.parse(mock_response_body))
        end 

        it_behaves_like 'a successful request'

        context 'when response code is 400 to 499' do
            it_behaves_like 'a failed request with code 400 to 499'
        end

        context 'when response code is 500 to 599' do
            it_behaves_like 'a failed request with code 500 to 599'
        end
    end

    describe '#get_story_details' do
        subject { service.get_story_details(external_story_id) }
        let(:story) { create(:story) }
        let(:external_story_id) { story.external_story_id }
        let(:uri) { URI("#{HackerNewsApi::BASE_URL}/v0/item/#{external_story_id}.json") }
        let(:response) { service.send(:response, uri) }
        let(:status) { 200 }
        let(:default_return) { {} }
        let(:mock_response_body) do 
            {                
                'by': 'a new news person',
                'descendants': 31,
                'id': 424242424,
                'kids': [42, 52],
                'score': 93,
                'time': 1314205301,
                'title': 'a new news story from a new news person',
                'type': 'story',
                'url': 'https://reallyrealnews.com/story/2'
            }.to_json
        end

        before do
            stub_request(:get, uri)
                .with(headers: {'Accept': 'application/json'})
                .to_return(status: status, body: mock_response_body)
        end


        it 'returns the parsed object data' do
            expect(subject).to eq(JSON.parse(mock_response_body))
        end 

        it_behaves_like 'a successful request'

        context 'when response code is 400 to 499' do
            it_behaves_like 'a failed request with code 400 to 499'
        end

        context 'when response code is 500 to 599' do
            it_behaves_like 'a failed request with code 500 to 599'
        end
    end

end