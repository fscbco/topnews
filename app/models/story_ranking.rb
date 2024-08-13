class StoryRanking < ApplicationRecord
  belongs_to :story

  # == Class Method: StoryRanking.top_stories
  #
  # Returns an array of stories ordered by their rank in descending order.
  # This method retrieves all instances of StoryRanking, orders them by the 'rank' attribute from highest to lowest,
  # and then collects the associated stories.
  #
  # === Usage
  #   # Example usage:
  #   top_stories = StoryRanking.top_stories
  #   top_stories.each do |story|
  #     puts story.title
  #   end
  # @return [Array<Story>] An array of stories ordered by rank.
  def self.top_stories
    all.order(rank: :desc).collect(&:story)
  end
end
