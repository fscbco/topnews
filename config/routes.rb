Rails.application.routes.draw do
  devise_for :users
  root to: 'stories#index'
  resources :stories, only: [:index] do
    post :mark_as_interesting, on: :collection
  end
end

