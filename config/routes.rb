Rails.application.routes.draw do
  devise_for :users
  resources :bookmarks, only: [:create, :destroy]

  get 'shared_stories', to: 'shared#index'
  get 'bookmarked_stories', to: 'main#bookmarked_stories'
  
  root to: 'main#index'
end
