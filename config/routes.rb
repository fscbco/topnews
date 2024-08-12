Rails.application.routes.draw do
  # Authentication routes
  devise_for :users

  # users
  get '/users', to: 'users#index'
  get '/users/:id/bookmarks', to: 'users#bookmarks'


  # Articles refresh
  get 'articles/refresh', to: 'articles#refresh'

  # Articles index page
  get 'articles', to: 'articles#index', as: 'articles'

  # Show a specific article
  get 'articles/:id', to: 'articles#show', as: 'article'

  # New article page
  get 'articles/new', to: 'articles#new', as: 'new_article'

  # Create a new article
  post 'articles', to: 'articles#create'

  # Edit article page
  get 'articles/:id/edit', to: 'articles#edit', as: 'edit_article'

  # Update an existing article
  patch 'articles/:id', to: 'articles#update'

  # Delete an article
  delete 'articles/:id', to: 'articles#destroy'

  # Root path - displays a list of recent news articles
  root 'articles#index'


  # Bookmarks index page
  get 'bookmarks', to: 'bookmarks#index', as: 'bookmarks'

  # Bookmark a specific article
  post 'bookmarks/:article_id', to: 'bookmarks#create', as: 'bookmark_article'

  # Unbookmark a specific article
  delete 'bookmarks/:article_id', to: 'bookmarks#destroy', as: 'unbookmark_article'


  # resources :articles do
  #   member do
  #     post :bookmark
  #     delete :unbookmark
  #   end
  # end

end
