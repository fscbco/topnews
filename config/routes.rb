Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'registrations'
  }
  root to: 'pages#home'
  resources :pages do
    put :flag, on: :member
  end
end
