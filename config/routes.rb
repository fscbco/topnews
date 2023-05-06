Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/top_stories', to: 'pages#top_stories'

end
