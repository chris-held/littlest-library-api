Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :libraries, only: [:show, :index, :create, :update]
  resources :library_flags, only: [:create]
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
