Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#top_stories'
  get 'saved-stories', to: 'pages#saved_stories'
  post 'save_story', to: 'pages#save_story'
end
