WmreccTimesheet::Application.routes.draw do

  root 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'configure', to: 'static_pages#configure'
  match 'configure_update', to: 'static_pages#configure_update', via: 'patch'
  match '/signin', to: 'static_pages#create',       via: 'post'
  match '/signout', to: 'static_pages#destroy',     via: 'delete'
  
  resources :users do
    resources :timesheets, except: :show
    get 'timesheets/single', to: 'timesheets#single'
    get 'timesheets/supervisor', to: 'timesheets#supervisor'
    get 'timesheets/admin', to: 'timesheets#admin'

    get 'timeoff/single',     to: 'timeoff#single'
    get 'timeoff/supervisor', to: 'timeoff#supervisor'
    get 'timeoff/admin',      to: 'timeoff#admin'
  end

  resources :categories, :departments

  get "*path", to:  'static_pages#route_error'
  
end