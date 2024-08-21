User.find_or_initialize_by(email: 'DonaldGMiller@example.com').update({
  first_name: 'Donald',
  last_name: 'Miller',
  password: 'eeMaev2shai'
})

User.find_or_initialize_by(email: 'LawrenceWGrant@example.com').update({
  first_name: 'Lawrence',
  last_name: 'Grant',
  password: 'ahR7iecai'
})

User.find_or_initialize_by(email: 'MargeRWilliams@example.com').update({
  first_name: 'Marge',
  last_name: 'Williams',
  password: 'Aechugh1ie'
})

def news_story_ids
  news_story_ids_uri      = URI('https://hacker-news.firebaseio.com/v0/newstories.json')
  news_story_ids_response = Net::HTTP.get(news_story_ids_uri)
  
  JSON.parse(news_story_ids_response)
end

def news_stories
  news_stories = news_story_ids
    .map do |news_story_id|
      news_story_id_uri   = URI("https://hacker-news.firebaseio.com/v0/item/#{news_story_id}.json")
      news_story_response = Net::HTTP.get(news_story_id_uri)

      JSON.parse(news_story_response)
    end
    .sort_by { |news_story| news_story['time'] }
    .reverse
    .map do |news_story| 
      NewsStory.create(
        id: news_story["id"],
        title: news_story["title"],
        story_type: news_story["type"],  
        url: news_story["url"],
        score: news_story["score"],
        descendants: news_story["descendants"],
        by: news_story["by"],
        time: news_story["time"]
      )

      news_story
    end
end

news_stories


  
