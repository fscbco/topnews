Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "stories#index", as: :authenticated_root
  end

  root to: 'pages#home'

  resources :stories, only: [:index, :show] do
    post 'flag', on: :member
  end

  get '/flagged_stories', to: 'stories#flagged'
end
