require 'metainspector'
class Story < ApplicationRecord
#  validates_presence_of :url
  belongs_to :user, optional: true
  before_save :get_info

  def get_info
    begin
      inspector = MetaInspector.new(self.url)
      self.title ||= inspector.best_title
      self.image_url ||= inspector.images.best
      rescue => details
        puts details
      end
  end

end
