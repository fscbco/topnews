Rails.application.routes.draw do


  devise_for :users
  root to: 'pages#index'


  resources :favourite_stories
  # get '/favourite_stories/:story_id/add', to: 'favourite_stories#add', as: 'add_to_favourites'
  get '/favourite_stories/:story_id/add', to: 'favourite_stories#add', as: 'add_to_favourites', defaults: { format: 'text/html' }
  get '/favourite_stories/:story_id/remove', to: 'favourite_stories#remove', as: 'remove_to_favourites', defaults: { format: 'text/html' }
  # resources :pages
end
