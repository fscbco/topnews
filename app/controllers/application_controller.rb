# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # making it work for MVP
  protect_from_forgery with: :null_session
end
