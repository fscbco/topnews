Rails.application.routes.draw do
  devise_for :users
  resources :stories
  get  '/stories'    => 'stories#index'
  get  '/starred_stories'    => 'stories#starred'
  post    '/starred_stories'    => 'stories#create',     as: 'star_story_path'
  get    '/stories/starred'    => 'stories#starred',     as: 'user_stories_path'
  get  '/stories/:id/:user_id'    => 'stories#star'   ,  as: 'star_stories_path'
  root to: 'stories#index'
  get  '/logout'    => 'devise/sessions#destroy'
  get  '/starred' => 'stories#user_starred'
end
