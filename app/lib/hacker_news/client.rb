# frozen_string_literal: true

require "net/http"
require "json"

module HackerNews
  class Client
    attr_accessor :base_uri

    BASE_URL = "https://hacker-news.firebaseio.com"

    # I don't think we really need this, but I thought
    # I'd show an alternative API
    class << self
      def story id
        new.story id
      end
    
      def top_stories
        new.top_stories
      end
    
      def top_story_ids
        new.top_story_ids
      end
    end

    def initialize version: 0
      @base_uri = "#{ BASE_URL }/v#{ version }/"
    end
  
    def story id
      response = _send_request( "item/#{ id }.json" )
      return if response == ""

      # can't use the identifier `type` in ActiveRecord
      Story.new( response.except( "type" ) ).tap { |s| s.story_type = response[ "type" ] }
    end
  
    def top_stories limit: 10
      # Don't like this; in fact, I hate it but it is neccessary as the HN topstories endpoint
      # returns only the IDs
      _send_request( "topstories.json" ).slice( 0...limit ).map do |story_id|
        story story_id
      end
    end
  
    def top_story_ids
      _send_request( "topstories.json" )
    end

    private

    def _send_request url_path
      uri = URI.join( base_uri, url_path )
      http = Net::HTTP.new( uri.host, uri.port )
      http.use_ssl = uri.scheme == "https"
  
      request = Net::HTTP::Get.new( uri )
      request[ "Content-Type" ] = "application/json"
  
      response = http.request( request )
      _respond response
    end

    def _respond response
      case response.code.to_i
      when 200 # here we can respond for any error code
        JSON.parse( response.body )
      else
        raise UnknownError, response.message
      end
    end

    class UnknownError < StandardError; end
  end
end
