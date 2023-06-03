Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'

  resources :stories, only: [:index] do
    post 'star', on: :member
  end
  get 'starred_stories', to: 'stories#starred', as: :starred_stories
end
