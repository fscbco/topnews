Rails.application.routes.draw do
  post 'stars/create'
  post 'stars/delete'
  devise_for :users
  root to: 'stories#home'
  get 'starred', to: 'stories#starred'
end
