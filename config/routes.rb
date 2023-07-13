Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :starred_stories, only: [:create]
end
