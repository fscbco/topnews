require "rails_helper"

describe "NewsClient" do
    let(:an_http_double) { double("http double") }

    subject { NewsClient.new(an_http_double) }

    context "topstories via ids" do
        it "should get a list of news ids" do
            topids = json_file("topstories.json")
            allow(an_http_double).to receive(:get).and_return(topids)

            expect(subject.ids()).to eq(topids)
        end
    end

    context "story via item(id)" do
        it "should get story details" do
            storyid = 8863
            story = json_file("item/8863.json")
            allow(an_http_double).to receive(:get).with("https://hacker-news.firebaseio.com/v0/item/#{storyid}.json").and_return(story)

            expect(subject.item(storyid)).to eq(story)
        end
    end
end
