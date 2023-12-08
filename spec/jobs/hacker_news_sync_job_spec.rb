require 'rails_helper'

RSpec.describe HackerNewsSyncJob, type: :job do

 before(:each) do 
   stub_request(:get, "https://hacker-news.firebaseio.com/v0/topstories.json").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Host'=>'hacker-news.firebaseio.com',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "[38565629]", headers: {})


   stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/38565629.json").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Host'=>'hacker-news.firebaseio.com',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "{\"by\":\"indigodaddy\",\"descendants\":3,\"id\":38565629,\"kids\":[38566040,38565819,38565826],\"score\":18,\"time\":1702011574,\"title\":\"Reviving decade-old Macs with antiX and MX Linux (2022)\",\"type\":\"story\",\"url\":\"https://sts10.github.io/2022/12/14/antix-on-2008-macbook-5-1.html\"}", headers: {})
 end

 it 'saves news story as top story in our db' do
    HackerNewsSyncJob.perform_now
    expect(Story.where(hacker_news_id: 38565629).sole).to have_attributes({title: 'Reviving decade-old Macs with antiX and MX Linux (2022)', top: true, url: 'https://sts10.github.io/2022/12/14/antix-on-2008-macbook-5-1.html'})
  end

 it 'saves hacker news url as url when url field is blank' do
   stub_request(:get, "https://hacker-news.firebaseio.com/v0/item/38565629.json").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Host'=>'hacker-news.firebaseio.com',
       	  'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "{\"by\":\"indigodaddy\",\"descendants\":3,\"id\":38565629,\"kids\":[38566040,38565819,38565826],\"score\":18,\"time\":1702011574,\"title\":\"Reviving decade-old Macs with antiX and MX Linux (2022)\",\"type\":\"story\"}", headers: {})

    HackerNewsSyncJob.perform_now

    expect(Story.where(hacker_news_id: 38565629).sole).to have_attributes({url:"https://news.ycombinator.com/item?id=38565629"})
  end

 it 'sets any stories with hacker news IDS that were not in the pull as NOT top stories' do
    story = Story.create!(top: true, title: 'test', hacker_news_id: 111111111, url: 'www.test.com')
    HackerNewsSyncJob.perform_now

    story.reload

    expect(story.top).to be_falsey
  end
end
