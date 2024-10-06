Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    get 'stories', to: 'stories#index', as: :user_root
  end

  unauthenticated do
    root to: 'pages#home'
  end

  resources :stories, only: [:index]
  get 'stories/index'
end
