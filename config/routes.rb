Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'
  resources :stories
  resources :stars, only: [:create, :destroy]
  get "/starred", to: 'stories#starred'
  get "/top", to: 'stories#index'

end
