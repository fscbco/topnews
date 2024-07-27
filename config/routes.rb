require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  namespace :api, defaults: { format: :json } do
    resources :stories, only: [:index] do
      resources :favorites, only: [:create, :destroy]
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
