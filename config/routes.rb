Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    get 'stories', to: 'stories#index', as: :user_root
  end

  unauthenticated do
    root to: 'pages#home'
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :stories, only: [:index]
  get 'stories/index'
end
