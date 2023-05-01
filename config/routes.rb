Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :stories
  resources :star

end
