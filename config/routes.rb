Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :feed
  resources :likes
  resources :liked_stories
end
