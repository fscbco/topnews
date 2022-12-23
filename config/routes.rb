Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users
  root to: 'home#index'

  post '/', to: 'home#index'
  get '/recommended_news', to: 'recommended_feeds#index', as: :recommended_news
  post '/recommended_news', to: 'recommended_feeds#index', as: :unrecommended_news
  get '/polls/feeds', to: 'polls#feeds', as: :poll_feeds
  get '/polls/feeds_poll', to: 'polls#feeds_poll', as: :feeds_poll_status
end
