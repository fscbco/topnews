class ApplicationController < ActionController::Base
  require 'rest-client'
  require 'json'
  protect_from_forgery with: :exception

  def call_api(url)
    response = RestClient.get(url)
    object = JSON.parse(response)
    return object
  end
end
