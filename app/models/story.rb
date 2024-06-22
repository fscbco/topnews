# frozen_string_literal: true

require "json"

class Story
  include ActiveModel::Model

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
end
