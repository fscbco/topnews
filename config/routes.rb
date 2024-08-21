Rails.application.routes.draw do
  devise_for :users
  root to: 'news_stories#index'
  resources :news_stories do
    member do
      post :pin
    end
  end
end
