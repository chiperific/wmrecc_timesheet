WmreccTimesheet::Application.routes.draw do

  root 'static_pages#home'
  get 'help', to: 'static_pages#help'
  match '/signin', to: 'static_pages#create',        via: 'post'
  match '/signout', to: 'static_pages#destroy',     via: 'delete'
  
  resources :users do
    resources :timesheets
  end

  resources :categories
  resources :departments
  
end