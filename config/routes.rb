Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'top_stories/index'
  root 'top_stories#index' # Route for our home page
  post 'top_stories/:id/star', to: 'top_stories#star', as: 'star_top_story'  # Route for starring a story
  get 'top_stories/flagged_stories', to: 'top_stories#flagged_stories', as: 'flagged_stories'
end
