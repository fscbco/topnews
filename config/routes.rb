Rails.application.routes.draw do
  devise_for :users
  get "stories", to: "stories#index"
  root to: 'stories#index'
end
