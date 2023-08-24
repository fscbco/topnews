RSpec.describe HackernewsClient do
  # TODO: add tests for error handling, mocking and parsing the JSON response
  describe '#get_top_stores' do
    context 'successful request' do
      before do
        allow(Net::HTTP).to receive(:get)
      end

      it 'makes a call to fetch top stories' do
        HackernewsClient.get_top_stories

        expect(Net::HTTP).to have_received(:get).with(URI('https://hacker-news.firebaseio.com/v0/topstories.json'))
      end
    end
  end

  describe '#get_story' do
    context 'successful request' do
      before do
        allow(Net::HTTP).to receive(:get)
      end

      it 'makes a call to fetch a story given an id' do
        HackernewsClient.get_story(8863)

        expect(Net::HTTP).to have_received(:get).with(URI('https://hacker-news.firebaseio.com/v0/item/8863.json'))
      end
    end
  end
end
