Rails.application.routes.draw do
  post 'stars/create'
  post 'stars/delete'
  devise_for :users
  root to: 'pages#home'
end
