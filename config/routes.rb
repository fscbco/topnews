Rails.application.routes.draw do

  devise_for :users

  get 'stories/view'
  get 'stories/recommendations'

  post 'recommendations/create/:story_id', to: 'recommendations#create', as: 'recommend'
  delete 'recommendations/destroy/:story_id', to: 'recommendations#destroy', as: 'unrecommend'

  root to: 'pages#home'
end
