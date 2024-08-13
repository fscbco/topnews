class Recommendation < ApplicationRecord
  belongs_to :user
  belongs_to :story

  # Retrieves all unique stories from the recommendations table.
  # This method queries the database for all recommended stories in the recommendations table
  # @return [Array<Story>] An array of unique stories.
  def self.stories
    all.distinct(:story).collect(&:story)
  end
end
