Rails.application.routes.draw do
  devise_for :users

  resources :stories, only: [:index] do
    post :star, on: :collection
    delete :unstar, on: :collection
    get :starred, on: :collection
  end

  root 'stories#index'

end
