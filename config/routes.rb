Rails.application.routes.draw do
  devise_for :users
  resources :stories
  get  '/stories'    => 'stories#index'
  get  '/starred_stories'    => 'stories#starred'
  post    '/starred_stories'    => 'stories#create',     as: 'starred_stories_path'
  root to: 'stories#index'
  get  '/logout'    => 'devise/sessions#destroy'
end
