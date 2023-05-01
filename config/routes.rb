Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'
  resources :stories
  resources :stars, only: [:create, :destroy]

end
