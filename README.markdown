This product is a Time tracking application for the explicit use of West Michigan Refugee Education and Cultural Center. created 2014 by Chiperific.com.

Adjustments from 10/5/14:
* Default date on new timesheet shows orange and pulses. It can't be blank.
* Clicking input-group-addons moves the focus to the next "input"

##
Issues:
# Is _timesheet_table doing the math right?
# Issue with Reviewed, Unapproved showing up with an approved date
# Clicking icon next to field for datepicker
# Show only unapproved && unreviewed timesheets -- maybe a separate button (for SV and Admin)
# "Choose any date within the payperiod" message below payroll_date select
# Payroll - Category - breakdown of staff contributions to category in a modal view



# Issue in timeoff (on host/users/1/timeoff/admin):
 Completed 500 Internal Server Error in 21ms
 ActionView::Template::Error (missing attribute: created_at):
     32:           <td><%= th.user.full_name %></td>
     33:           <td><%= t.week_num_to_date %></td>
     34:           <td><%= t.timesheet_hours.where(user_id: th.user.id).sum(:timeoff_hours) %></td>
     35:           <td class="hidden-xs"><%= th.created_at.strftime("%m/%d/%Y") %></td>
     36:           <td><%= th.status %></td>
     37:           <td><%= link_to FA_EDIT, edit_user_timesheet_path( th.user.id, t.id), class: "btn btn-primary btn-sm" %></td>
     38:         </tr>
   app/views/timeoff/_timeoff_table.html.erb:35:in `block in _app_views_timeoff__timeoff_table_html_erb__1178901595723176970_70164917795600'
   app/views/timeoff/_timeoff_table.html.erb:29:in `each'
   app/views/timeoff/_timeoff_table.html.erb:29:in `_app_views_timeoff__timeoff_table_html_erb__1178901595723176970_70164917795600'
   app/views/timeoff/admin.html.erb:3:in `_app_views_timeoff_admin_html_erb___3649900936495241982_70164917748240'
   app/controllers/application_controller.rb:70:in `user_time_zone'
 
 ActionView::Template::Error (missing attribute: created_at):
     32:           <td><%= th.user.full_name %></td>
     33:           <td><%= t.week_num_to_date %></td>
     34:           <td><%= t.timesheet_hours.where(user_id: th.user.id).sum(:timeoff_hours) %></td>
     35:           <td class="hidden-xs"><%= th.created_at.strftime("%m/%d/%Y") %></td>
     36:           <td><%= th.status %></td>
 Started GET "/users/1/timeoff/admin" for 162.196.16.242 at 2014-11-05 16:11:18 +0000
 
 
     37:           <td><%= link_to FA_EDIT, edit_user_timesheet_path( th.user.id, t.id), class: "btn btn-primary btn-sm" %></td>
     38:         </tr>
   app/views/timeoff/_timeoff_table.html.erb:35:in `block in _app_views_timeoff__timeoff_table_html_erb__1178901595723176970_70164918279980'
   app/views/timeoff/_timeoff_table.html.erb:29:in `each'
   app/views/timeoff/_timeoff_table.html.erb:29:in `_app_views_timeoff__timeoff_table_html_erb__1178901595723176970_70164918279980'
   app/views/timeoff/admin.html.erb:3:in `_app_views_timeoff_admin_html_erb___3649900936495241982_70164918263160'
   app/controllers/application_controller.rb:70:in `user_time_zone'