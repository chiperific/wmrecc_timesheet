WmreccTimesheet::Application.routes.draw do

  root 'static_pages#home'
  get 'help', to: 'static_pages#help'

  resources :users do
    resource :requests
  end

  resources :categories
  resources :departments
  
  resources :sessions, only: [:create, :destroy]
  match '/signout', to: 'static_pages#destroy',     via: 'delete'
end

#             Prefix Verb   URI Pattern                             Controller#Action
#              root GET    /                                       static_pages#home
#              help GET    /help(.:format)                         static_pages#help
#     user_requests POST   /users/:user_id/requests(.:format)      requests#create
# new_user_requests GET    /users/:user_id/requests/new(.:format)  requests#new
#edit_user_requests GET    /users/:user_id/requests/edit(.:format) requests#edit
#                   GET    /users/:user_id/requests(.:format)      requests#show
#                   PATCH  /users/:user_id/requests(.:format)      requests#update
#                   PUT    /users/:user_id/requests(.:format)      requests#update
#                   DELETE /users/:user_id/requests(.:format)      requests#destroy
#             users GET    /users(.:format)                        users#index
#                   POST   /users(.:format)                        users#create
#          new_user GET    /users/new(.:format)                    users#new
#         edit_user GET    /users/:id/edit(.:format)               users#edit
#              user GET    /users/:id(.:format)                    users#show
#                   PATCH  /users/:id(.:format)                    users#update
#                   PUT    /users/:id(.:format)                    users#update
#                   DELETE /users/:id(.:format)                    users#destroy
#        categories GET    /categories(.:format)                   categories#index
#                   POST   /categories(.:format)                   categories#create
#      new_category GET    /categories/new(.:format)               categories#new
#     edit_category GET    /categories/:id/edit(.:format)          categories#edit
#          category GET    /categories/:id(.:format)               categories#show
#                   PATCH  /categories/:id(.:format)               categories#update
#                   PUT    /categories/:id(.:format)               categories#update
#                   DELETE /categories/:id(.:format)               categories#destroy
#       departments GET    /departments(.:format)                  departments#index
#                   POST   /departments(.:format)                  departments#create
#    new_department GET    /departments/new(.:format)              departments#new
#   edit_department GET    /departments/:id/edit(.:format)         departments#edit
#        department GET    /departments/:id(.:format)              departments#show
#                   PATCH  /departments/:id(.:format)              departments#update
#                   PUT    /departments/:id(.:format)              departments#update
#                   DELETE /departments/:id(.:format)              departments#destroy
#          sessions POST   /sessions(.:format)                     sessions#create
#           session DELETE /sessions/:id(.:format)                 sessions#destroy
#           signout DELETE /signout(.:format)                      static_pages#destroy
