# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'stories/index'
  devise_for :users
  resources :stories
end
