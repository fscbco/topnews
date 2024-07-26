Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'
  resources :stories
  resources :favorites, only: [:create, :destroy]
  resources :users, only: [:index] do
    resources :favorites, only: [:index]
  end
end
