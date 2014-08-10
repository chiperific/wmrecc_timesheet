                    Prefix Verb   URI Pattern                                     Controller#Action
                      root GET    /                                               static_pages#home
                      help GET    /help(.:format)                                 static_pages#help
                 configure GET    /configure(.:format)                            static_pages#configure
          configure_update PATCH    /configure_update(.:format)                     static_pages#configure_update
                    signin POST   /signin(.:format)                               static_pages#create
                   signout DELETE /signout(.:format)                              static_pages#destroy
           user_timesheets GET    /users/:user_id/timesheets(.:format)            timesheets#index
                           POST   /users/:user_id/timesheets(.:format)            timesheets#create
        new_user_timesheet GET    /users/:user_id/timesheets/new(.:format)        timesheets#new
       edit_user_timesheet GET    /users/:user_id/timesheets/:id/edit(.:format)   timesheets#edit
            user_timesheet PATCH  /users/:user_id/timesheets/:id(.:format)        timesheets#update
                           PUT    /users/:user_id/timesheets/:id(.:format)        timesheets#update
                           DELETE /users/:user_id/timesheets/:id(.:format)        timesheets#destroy
    user_timesheets_single GET    /users/:user_id/timesheets/single(.:format)     timesheets#single
user_timesheets_supervisor GET    /users/:user_id/timesheets/supervisor(.:format) timesheets#supervisor
     user_timesheets_admin GET    /users/:user_id/timesheets/admin(.:format)      timesheets#admin
       user_timeoff_single GET    /users/:user_id/timeoff/single(.:format)        timeoff#single
   user_timeoff_supervisor GET    /users/:user_id/timeoff/supervisor(.:format)    timeoff#supervisor
        user_timeoff_admin GET    /users/:user_id/timeoff/admin(.:format)         timeoff#admin
                     users GET    /users(.:format)                                users#index
                           POST   /users(.:format)                                users#create
                  new_user GET    /users/new(.:format)                            users#new
                 edit_user GET    /users/:id/edit(.:format)                       users#edit
                      user GET    /users/:id(.:format)                            users#show
                           PATCH  /users/:id(.:format)                            users#update
                           PUT    /users/:id(.:format)                            users#update
                           DELETE /users/:id(.:format)                            users#destroy
                categories GET    /categories(.:format)                           categories#index
                           POST   /categories(.:format)                           categories#create
              new_category GET    /categories/new(.:format)                       categories#new
             edit_category GET    /categories/:id/edit(.:format)                  categories#edit
                  category GET    /categories/:id(.:format)                       categories#show
                           PATCH  /categories/:id(.:format)                       categories#update
                           PUT    /categories/:id(.:format)                       categories#update
                           DELETE /categories/:id(.:format)                       categories#destroy
               departments GET    /departments(.:format)                          departments#index
                           POST   /departments(.:format)                          departments#create
            new_department GET    /departments/new(.:format)                      departments#new
           edit_department GET    /departments/:id/edit(.:format)                 departments#edit
                department GET    /departments/:id(.:format)                      departments#show
                           PATCH  /departments/:id(.:format)                      departments#update
                           PUT    /departments/:id(.:format)                      departments#update
                           DELETE /departments/:id(.:format)                      departments#destroy
                           GET    /*path(.:format)                                static_pages#route_error