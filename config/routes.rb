Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'stars', to: 'pages#starred_stories'

  post 'star_story/:id', to: 'pages#star_story'
  post 'unstar_story/:id', to: 'pages#unstar_story'
end
