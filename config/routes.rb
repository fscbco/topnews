Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  root to: 'pages#home'

  post '/', to: 'pages#home'
  get '/recommended_news', to: 'recommended_feeds#show', as: :recommended_news
  post '/recommended_news', to: 'recommended_feeds#show', as: :unrecommended_news
end
