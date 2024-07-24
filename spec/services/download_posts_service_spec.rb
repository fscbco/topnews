require 'rails_helper'

describe DownloadPostsService, :vcr do
  describe '#download_stories' do
    subject(:download) { DownloadPostsService.new.download_stories }

    context 'success' do
      context 'when there are no posts in the database' do
        it 'creates posts' do
          expect { download }.to change(Post, :count).by(19)
          # hacker news item #41_059_148 is a job so it will not be saved
          expect(Post.find_by(id: 41_059_148)).to be_nil
        end
      end

      context 'when there are posts in the database' do
        context 'when the newest post from HN is already in the database' do
          before do
            create(:post, id: 41_060_102)
          end

          it 'does not create posts' do
            expect { download }.not_to change(Post, :count)
          end
        end

        context 'when the oldest post from HN is not in the database' do
          before do
            create(:post, id: 1)
          end

          it 'does not create posts' do
            expect { download }.to change(Post, :count).by(19)
          end
        end
      end
    end

    context 'failure' do
      context 'when there is an error' do
        before do
          allow(HackerNewsClient).to receive(:fetch_top_stories).and_raise(StandardError)
        end

        it 'raises an error' do
          expect { download }.to raise_error(StandardError)
        end
      end
    end
  end
end
