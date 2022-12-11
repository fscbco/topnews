require 'rails_helper'

describe 'PostsController', type: :request do
  describe '#index' do
    let(:fetch_top_stories) { instance_double HackerNews::FetchTopStories }

    before do
      allow(HackerNews::FetchTopStories).to receive(:new).and_return(fetch_top_stories)
      allow(fetch_top_stories).to receive(:call)
    end

    context 'when a user is signed in' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'renders the page' do
        get posts_path
        expect(response).to be_successful
      end

     it 'renders posts' do
       existing_post = create(:post)
       get posts_path

       expect(response.body).to include existing_post.title
       expect(response.body).to include existing_post.url
       expect(response.body).to include existing_post.author
       expect(response.body).to include "https://news.ycombinator.com/item?id=#{existing_post.hn_id}"

       uri = URI(existing_post.url)
       expect(response.body).to include "#{uri.scheme}://#{uri.host}"
      end

     context 'when a post is starred' do
       it 'shows who it was starred by' do
         star = create(:star)
         get posts_path
         expect(response.body).to include("#{star.user.first_name} #{star.user.last_name}")
       end
     end

     context 'when a post is starred by more than 3 people' do
       it 'truncates starred by' do
         post_obj = create(:post)
         displayed_stars = create_list(:star, 3, post: post_obj)
         truncated_stars = create_list(:star, 2, post: post_obj)
         get posts_path

         displayed_stars_names = displayed_stars.map { |star| "#{star.user.first_name} #{star.user.last_name}" }
         truncated_stars_names = truncated_stars.map { |star| "#{star.user.first_name} #{star.user.last_name}" }
         expect(response.body).to include(*displayed_stars_names)
         expect(response.body).to include('and 2 more')
         expect(response.body).not_to include(*truncated_stars_names)
       end
     end

     context 'when filter params is starred' do
       it 'returns starred posts' do
         starred_post = create(:post, :with_stars)
         get posts_path(filter: 'starred')
         expect(response.body).to include starred_post.title
       end

       it 'does not return posts that are not starred' do
         starred_post = create(:post, :with_stars)
         unstarred_post = create(:post)
         get posts_path(filter: 'starred')
         expect(response.body).not_to include unstarred_post.title
       end
     end

     context 'when search params are provided' do
       let(:found_title) { 'Awesome Story on Hacker News!' }
       let(:found_post) { create(:post, title: found_title) }
       let(:not_found_title) { 'This Has Nothing In Common With found_title!' }
       let(:not_found_post) {  create(:post, title: not_found_title) }

       before do
         found_post
         not_found_post
       end

       it 'searches by title' do
         get posts_path(search: 'awesome')
         expect(response.body).to include(found_post.title)
         expect(response.body).not_to include(not_found_post.title)
       end

       it 'renders the search title' do
         get posts_path(search: 'awesome')
         expect(response.body).to include('Search results for &quot;awesome&quot;')
       end
     end

     describe '#fetch_top_stories (after_action)' do
       context 'when the page number is greater than 1' do
         it 'does not refresh top stories' do
           get posts_path(page: 2)
           expect(HackerNews::FetchTopStories).not_to have_received(:new)
         end
       end

       context 'when the page number is less than 1' do
         context 'when the latest story is more than 1 hour old' do
           let(:old_post) { create(:post, hn_created_at: 2.hours.ago) }

           before do
             Post.destroy_all
             old_post
           end

           it 'refreshes top stories' do
             get posts_path
             expect(HackerNews::FetchTopStories).to have_received(:new)
           end
         end

         context 'when the latest story is less than 1 hour old' do
           it 'does not refresh top stories' do
             create(:post, hn_created_at: DateTime.now)
             get posts_path
             expect(HackerNews::FetchTopStories).not_to have_received(:new)
           end
         end
       end
     end
    end

    context 'when a user is not signed in' do
      it 'redirects to sign in' do
        get posts_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
