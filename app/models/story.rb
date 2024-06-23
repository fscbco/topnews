# frozen_string_literal: true

require "json"

class Story
  include ActiveModel::Model
  include Draper::Decoratable

  attr_accessor :id, 
    :by,
    :dead,
    :deleted,
    :descendants, 
    :kids,
    :parent,
    :parts,
    :poll,
    :score, 
    :text,
    :time, 
    :title, 
    :type, 
    :url

  def self.from_json json
    begin
      new JSON.parse( json )
    rescue JSON::ParserError, TypeError
      Rails.logger.error( "Failed to parse JSON" )
    end
  end

  def flagged_by
    @flagged_by ||= 
      User
        .joins( :flagged_stories )
        .where( flagged_stories: { story_id: self.id } )
  end

  def flag! user:
    FlaggedStory.find_or_create_by( story_id: id, user: user )
  end
end
