WmreccTimesheet::Application.routes.draw do
  root 'static_pages#home'
  get 'help', to: 'static_pages#help'

  resources :users
  resources :categories
  resources :departments
  
  resources :sessions, only: [:create, :destroy]
  match '/signout', to: 'static_pages#destroy',     via: 'delete'
end
