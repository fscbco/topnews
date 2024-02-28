Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'favorites', to: 'pages#favorites', as: 'favorites'
  resources :articles, only: [:show]
  post '/articles/:id/favorite', to: 'articles#favorite', as: 'favorite'

end
