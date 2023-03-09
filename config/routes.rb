# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts, only: %i[index]
  resources :favorites, only: %i[create destroy]
  devise_for :users
  root to: 'posts#index'
end
