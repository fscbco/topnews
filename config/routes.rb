Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/interesting_stories', to: 'pages#interesting_stories', as: :interesting_stories
  post '/favorite', to: 'favorites#create', as: :favorite_create
  delete '/favorite', to: 'favorites#destroy', as: :favorite_destroy

end
