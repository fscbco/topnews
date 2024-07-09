Story = Struct.new(:id, :title, :url, :by, :created_at, keyword_init: true) do
  def self.load(id)
    uri = URI("https://hacker-news.firebaseio.com/v0/item/#{id}.json")
    res = Net::HTTP.get_response(uri)
    details = JSON.parse(res.body)

    new(
      id:,
      title: details.fetch('title'),
      url: details.fetch('url', "https://news.ycombinator.com/item?id=#{id}"),
      by: details.fetch('by'),
      created_at: Time.at(details.fetch('time'))
    )
  end

  def self.top(n)
    top_ids(n).map { |id| load(id) }
  end

  def self.starred
    ids = StoryStar.select(:story_id).distinct.pluck(:story_id)

    ids.map { |id| load(id) }
  end

  def starred_by
    User.joins(:story_stars).where(story_stars: { story_id: id })
  end

  def starred_by?(user)
    user.story_stars.exists?(story_id: id)
  end

  private_class_method def self.top_ids(n)
    uri = URI('https://hacker-news.firebaseio.com/v0/topstories.json')
    res = Net::HTTP.get_response(uri)
    ids = JSON.parse(res.body)

    ids.take(n)
  end
end
