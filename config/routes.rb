WmreccTimesheet::Application.routes.draw do

  root 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'signout', to: 'static_pages#destroy',     via: 'delete'

  resources :users do
    
    resources :requests
    get '/requests/:request_id/approval_flow', to: 'requests#approval_flow'
    post '/requests/create_all', to: 'requests#create_all_requests'
  end

  resources :categories
  resources :departments
  resources :sessions, only: [:create, :destroy]
  
end