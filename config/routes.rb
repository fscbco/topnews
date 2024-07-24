require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  mount Sidekiq::Web => '/sidekiq'
end
