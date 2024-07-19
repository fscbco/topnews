Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  post 'pages/toggle_star/:id', to: 'pages#toggle_star', as: 'toggle_star'
  get 'pages/starred_stories', to: 'pages#starred_stories', as: 'starred_stories'
end
