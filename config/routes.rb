Rails.application.routes.draw do
  resources :flagged_stories
  root to: 'pages#home'
  get '/news', to: 'news#index'
  devise_for :users
end
