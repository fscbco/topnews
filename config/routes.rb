Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :stories do
end


  # Catch-all route for handling unmatched routes
  match "*path", to: "errors#not_found", via: :all
end
