Rails.application.routes.draw do
  get 'current_user', to: 'current_user#index'
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
   controllers: {
     sessions: 'users/sessions',
     registrations: 'users/registrations'
   }
  root to: 'pages#home'
  resources :stories, defaults: { format: 'json' }, only: [:index, :show] do
    member do
      put 'like'
      put 'unlike'
    end
  end
  get 'likes', to: 'stories#index_liked', defaults: { format: 'json' }
  put 'users/:id', to: 'users#update', defaults: { format: 'json' }
end
