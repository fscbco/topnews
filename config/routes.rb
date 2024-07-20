Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :hacker_news_recommendations, only: [:create, :destroy]
end
