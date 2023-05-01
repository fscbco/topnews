# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'stories/index'
  devise_for :users
  resources :stories

  get '/fetch_current_user', to: 'users#fetch_current_user'
  post '/star_story', to: 'stories#star_story'
end
