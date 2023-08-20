Rails.application.routes.draw do
  devise_for :users
  post "/favorite", to: "favorites#create"
  root to: 'pages#home'
end
