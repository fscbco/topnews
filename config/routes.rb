Rails.application.routes.draw do
  devise_for :users
  resources :stories
  get  '/starred_stories'    => 'starred_stories#index'
  post    '/starred_stories'    => 'starred_stories#create',     as: 'starred_stories_path'
  root to: 'pages#home'

end
