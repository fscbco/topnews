require 'rails_helper'

RSpec.describe StoryService do
    let(:service) { described_class.new(user) }
    let(:user) { create(:user) }
    let!(:story_1) { create(:story) }
    let!(:story_2) { create(:story, external_story_id: 2) }
    let!(:story_3) { create(:story, external_story_id: 3) }
    let(:hacker_news_api_stories_id_response) do 
        [story_1.external_story_id, story_2.external_story_id, story_3.external_story_id]
    end
    let!(:processed_data) do
        [
            {story: story_1, favorite: '', count: 0, favorite_by_user: false},
            {story: story_2, favorite: '', count: 0, favorite_by_user: false},
            {story: story_3, favorite: '', count: 0, favorite_by_user: false}
        ]
    end

    describe '#new / initialize' do
        it 'can initialize with a user' do
            expect(service.user).to eq(user)
        end

        context 'when a user is not provided' do
            let(:user) { nil }

            it 'can initialize without a user' do
                expect(service.user).to be_nil
            end
        end
    end

    describe '#get_stories_data' do
        subject { service.get_stories_data }

        before do
            allow(service).to receive(:get_stories_ids_from_api).and_return(hacker_news_api_stories_id_response)
        end

        it 'calls the HackerNewsApi to fetch story ids' do
            expect(service).to receive(:get_stories_ids_from_api)

            subject
        end

        it 'process the story ids' do
            expect(service).to receive(:process_external_story_id_data)
                .with(hacker_news_api_stories_id_response)
                .and_return(processed_data)
                
            expect(subject).to eq(processed_data)
        end
    end

    describe '#get_interesting_stories' do
        subject { service.get_interesting_stories }
        let(:another_user) { create(:user, first_name: "tester", email: 'faker@l.c')}
        let(:processed_data) do 
            [
                {story: story_1, favorite: 'foo, tester', count: 2, favorite_by_user: true}
            ]
        end

        before do
            Favorite.create!(user_id: user.id, story_id: story_1.id)
            Favorite.create!(user_id: another_user.id, story_id: story_1.id)
        end

        it 'process the story ids' do
            expect(service).to receive(:process_external_story_id_data)
                .with([story_1.external_story_id])
                .and_return(processed_data)
                
            expect(subject).to eq(processed_data)
        end
    end

    describe '#generate_story_data_hash' do
        subject { service.send(:generate_story_data_hash, story_1) }

        it 'generates a hash with story, favorite, count, and favorite_by_user keys' do
            expect(subject).to eq(processed_data.first)
            expect(subject).to have_key(:story)
            expect(subject).to have_key(:favorite)
            expect(subject).to have_key(:count)
            expect(subject).to have_key(:favorite_by_user)
        end
    end

    describe '#find_or_fetch_story' do
        subject { service.send(:find_or_fetch_story, story_id_for_lookup) }
        let(:story_id_for_lookup) { story_1.external_story_id}

        it 'query database and return story if it exists' do
            expect(subject).to eq(story_1)
        end

        context 'when the story does not exist' do
            let(:story_id_for_lookup) { 'some random val' }

            it 'attempt to fetch the data from HackerNewsApi' do
                expect(service).to receive(:fetch_and_create_story).with(story_id_for_lookup)
                subject
            end

            context 'if HackerNewsApi fails to fetch' do
                before do
                    allow(service).to receive(:fetch_and_create_story).with(story_id_for_lookup).and_return(nil)
                end

                it 'returns nil' do
                    expect(subject).to be_nil
                end
            end
        end
    end

    describe '#fetch_and_create_story' do
        subject { service.send(:fetch_and_create_story, story_1.external_story_id) }
        let(:fetched_story_data) do
            HashWithIndifferentAccess.new(
                'by': 'a new news person',
                'descendants': 31,
                'id': 424242424,
                'kids': [42, 52],
                'score': 93,
                'time': 1314205301,
                'title': 'a new news story from a new news person',
                'type': 'story',
                'url': 'https://reallyrealnews.com/story/2'
            )
        end

        before do
            allow(service).to receive(:get_story_data_from_api).with(story_1.external_story_id).and_return(fetched_story_data)
        end

        it 'calls the HackerNewsApi to fetch story data' do
            expect(service).to receive(:get_story_data_from_api).with(story_1.external_story_id)

            subject
        end

        it 'creates a new story with the fetched data' do
            expect { subject }.to change { Story.count }.by(1)
        end

        context 'when api call fails' do
            let(:fetched_story_data) { nil }

            it 'does not create a story' do
                expect { subject }.not_to change { Story.count }
            end
        end
    end

    describe '#generate_favorite_user_string' do
        subject { service.send(:generate_favorite_user_string, usernames) } 
        let(:usernames) { ["Donald", "Lawrence", "Marge"] }

        it 'returns a string with the usernames' do
            expect(subject).to eq(usernames.join(", "))
        end

        context 'when 4 or more usernames' do
            before do
                usernames.unshift('Tony')
            end
            
            it 'returns only the first 3 usernames and additional message' do
                expect(subject).to eq( "#{usernames.first(3).join(', ')}, and #{usernames.count - 3} more" )
            end
        end
    end

    describe '#story_favorite_by_users' do
        subject { service.send(:story_favorite_by_users, story_1) }

        before do
            Favorite.create!(user_id: user.id, story_id: story_1.id)
        end

        it 'returns a list of usernames that have favorited this story' do
            expect(subject).to include(user.first_name)
        end
    end

    describe '#favorite_by_user?' do
        subject { service.send(:favorite_by_user?, story_to_check)}
        let(:story_to_check) { story_1 }

        before do
            Favorite.create!(user_id: user.id, story_id: story_1.id)
        end

        it 'returns a true boolean when user did favorite this story' do
            expect(subject).to be true
        end

        context 'when a favorite record is not found' do
            let(:story_to_check) { story_2 }

            it 'returns a false boolean' do
                expect(subject).to be false
            end
        end

    end
end