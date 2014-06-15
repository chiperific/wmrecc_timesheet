WmreccTimesheet::Application.routes.draw do
  root 'static_pages#home'
  get 'help', to: 'static_pages#help'

  resources :users
  resources :categories
  resources :departments
  
  resources :sessions, only: [:new, :create, :destroy]

  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
end
