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


  def index
    @stories = Story.find_or_initialize_by(HackerRankNews.new.get_top_stories.first(25).include?(story_id))
  end

  def update
      story = HackerRankNews.new.get_top_stories.first(25).include?(Story.find_by(story_id: story_id))
      # story = Story.find_or_initialize_by(story_id: story_id)
      story.hr_news_story
      story.save
  end

end
