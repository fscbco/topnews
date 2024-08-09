Rails.application.routes.draw do
  root to: 'stories#top'

  devise_for :users

  devise_scope :users do
    get "show_user/:id" => "users#show", as: :show_user
  end

  resources :stories
  resources :likes

end
