Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :feed, only: :index
  resources :likes, only: :create
  resources :liked_stories, only: :index
end
