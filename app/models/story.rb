# frozen_string_literal: true

class Story < ApplicationRecord
  def update_story(hn_story)
    self.by = hn_story['by']
    self.published_at = Time.at(hn_story['time'])
    self.title = hn_story['title']
    self.link = hn_story['url']
    save
  end
end
