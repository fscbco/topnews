Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'

  post 'flagged_stories/add/', to: 'flagged_stories#add', as: 'flag_add'
  get 'flagged_stories/remove/:id/', to: 'flagged_stories#remove', as: 'flag_remove'
end
