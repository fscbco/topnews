Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'

  resources :stories, only: [] do
    member do
      post 'star'
      delete 'unstar'
    end
    collection do
      get 'starred'
      get 'fetch_latest_news'
    end
  end
end