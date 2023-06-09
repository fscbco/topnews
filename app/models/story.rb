class Story < ApplicationRecord
  has_many :likes, dependent: :destroy
  validates :title, presence: true
  validates :time, presence: true
  validates :by, presence: true


  def self.build_from_input(story_input)
    # This is a good place to put any extra validation/builder logic if needed
    filtered_input = story_input.slice(:id, :title, :text, :url, :score, :by, :descendants, :time)
    filtered_input[:time] = Time.at(story_input[:time]) if story_input.key?(:time)
    Story.create!(filtered_input)
  end

  def update_mutable(story_input)
    self.by = story_input[:by] if story_input.key?(:by)
    self.title = story_input[:title] if story_input.key?(:title)
    self.descendants = story_input[:descendants] if story_input.key?(:descendants)
    self.time = story_input[:time] if story_input.key?(:time)
    self.url = story_input[:url] if story_input.key?(:url)
    self.text = story_input[:text] if story_input.key?(:text)
    self.save!
    self
  end

  def liked_by
    User.get_first_names(self.likes.pluck(:user_id).uniq)
  end

  # this is nice for grabbing single stories, but will thrash the db
  # if multiple times with a large number of un-cached ids
  def self.get_story(id)
    Story.find_by(id: id) || get_new_story(id)
  end

  # split out from the above so we can call it directly in get_stories
  def self.get_new_story(id)
    story_input = HackerNewsService.instance.get_story(id)
    return nil if story_input.nil?
    # this is awful, and will slam the database with single-inserts
    build_from_input(story_input)
  end

  # This should probably just be done on the client side, but it's a ruby take home
  # so let's do it here and save the full object as a model. This will be a bit
  # slow, but should be fine for the number of stories we're dealing with.
  #
  # Realistically, we'd probably want to just keep the IDs for the stories since
  # that's all we need for the likes.
  def self.get_stories(ids = nil)
    ids ||= HackerNewsService.instance.top_stories
    # I usually don't like to convert relations to arrays, but this
    # will let us merge in the new models we're creating below
    stories = Story.where(id: ids).to_a
    found_ids = stories.map(&:id)
    ids.filter { |id| !found_ids.include?(id) }.each do |id|
      stories << get_new_story(id)
    end
    stories
  end

  # we can call this from a job to keep our stories up to date and invalidate
  # the cache entries in the service class
  def self.refresh_stories(ids = nil)
    refresh_ids = ids || HackerNewsService.instance.get_updated_stories
    refresh_ids.each do |id|
      story_input = HackerNewsService.instance.get_story(id)
      Story.update_mutable(story_input) if story_input
    end
  end
end
