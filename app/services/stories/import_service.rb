# frozen_string_literal: true

module Stories
  class ImportService
    def self.run!
      ::HackerNews::Client.top_story_ids.each do |id|
        if Story.find_by( id: id )
          puts "Story (#{ id }) already exists"
        else
          puts "Story (#{ id }) imported"
          ::HackerNews::Client.story( id )&.save!
        end
      end
    end
  end
end
