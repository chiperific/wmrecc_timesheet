WmreccTimesheet::Application.routes.draw do

  root 'static_pages#home'
  get 'help', to: 'static_pages#help'
  get 'configure', to: 'static_pages#configure'

  get '/holidays/:year', to: 'app_default#holidays' #ajax call
  get '/payroll_cats_users/:cat_id/:payroll_start/:payroll_end', to: 'categories#payroll_users'

  match 'configure_update', to: 'static_pages#configure_update', via: 'patch'

  match '/signin', to: 'static_pages#create',       via: 'post'
  match '/signout', to: 'static_pages#destroy',     via: 'delete'
  match "payroll", to: 'static_pages#payroll',      via: 'get'


  resources :users do
    resources :timesheets, except: :show
    get 'timesheets/single', to: 'timesheets#single'
    get 'timesheets/supervisor', to: 'timesheets#supervisor'
    get 'timesheets/admin', to: 'timesheets#admin'

    get 'timesheets/archive', to: 'timesheets#archive'

    get 'timeoff/single',     to: 'timeoff#single'
    get 'timeoff/supervisor', to: 'timeoff#supervisor'
    get 'timeoff/admin',      to: 'timeoff#admin'
  end

  resources :categories, :departments

  get "*path", to:  'static_pages#route_error'
  
end