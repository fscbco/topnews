# frozen_string_literal: true

Rails.application.routes.draw do
  resources :stories do
    resources :stars, only: [:create]
  end
  devise_for :users
  root to: 'pages#home'
end
