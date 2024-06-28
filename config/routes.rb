Rails.application.routes.draw do
  get 'stories/index'
  get 'stories/like'
  devise_for :users
  root to: 'pages#home'
end
