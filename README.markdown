This product is a Time tracking application for the explicit use of West Michigan Refugee Education and Cultural Center. created 2014 by Chiperific.

## Last completed step:
* custom routes for timesheet (except: :show) and timeoff
* 'all bad routes' catcher routes to static_pages#route_error
* Implement ActiveRecord::RecordNotFound handler
* Flesh out Weekday model
* Create AppDefault model / controller
0.2. Refractor the .all calls with .to_a
* static_pages_spec#config
* timeoff_pages_spec

## Next steps:
* timesheet_pages_spec#new, edit
0.1. Create nested form for Weekdays through AppDefault.first

1. draft timeoff views
  * \_single\_timeoff table done
    * needs alert for denied timeoff
  * \_auth\_over\_timeoff and \_auth\_admin\_timeoff need tables
2. timeoff views need sums:
  * timeoff used && remaining between date ranges with 'only approved' || 'all submitted'
3. UX validation of hours and cats
  * Progress bars:
    1. TH.hrs vs. user.standard_hours
    2. TC.hrs vs. TH.hrs
4. Reports
  1.0 Timeoff reports through 'users/#/timeoff/{level}'
  1.1 Timesheet reports through 'users/#/report/{level}'
    * Between dates - s, sv, ad
    * Staff selector - sv, ad
    * TS && TO
  2. http://guides.rubyonrails.org/active_record_querying.html#retrieving-multiple-objects

5. Destroy action for user with delete nested models

## Minor tweaks:
* Timesheet#update redirects to the timesheet#index for the user from the params. Maybe an issue?
* Timesheet_controller#new and #edit - building weekdays and cats is not DRY


## Keep in mind:
* http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model
* .hidden-xs - to hide data on small screens
* You have a datepicker: http://bootstrap-datepicker.readthedocs.org/en/release/index.html
* Rails knows week numbers:
  * http://stackoverflow.com/questions/4389395/how-do-i-get-a-date-from-a-week-number
  * http://ruby-doc.org/stdlib-2.1.2/libdoc/date/rdoc/Date.html#method-c-commercial
* Font Awesome submit buttons
  ```ruby
    <button type="submit" class="btn btn-success">
      <%= FA_SUBMIT %>
    </button>
  ```

## Add-ons:
1. Progress bars:
  * number of total hours you worked --> (categorize hours) --> updates progress bar
  ```ruby
  <div class="progress">
    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
      <span class="sr-only">40% Complete (success)</span>
    </div>
  </div>
  ```

## Ongoing issues:

* Controllers are fat and messy...
* Instead of .each = use partial '', collection: @var, as: :var

## Manlycode will save me!
* RSpec - pending specs - need a stub?
* Why doesn't this set current\_user: let(:current_user) {user}
  * Getting `undefined method `admin?' for nil:NilClass` on current_user.admin
  * before_action calls are wreacking havoc?


## Setup configurations
* Annual timeoff - calendar year vs fiscal year
* TimeZone => application.rb::WmreccTimesheet::config.time_zone
* Start of week => TimsheetHour::day_name && self.day_name
* Include Sat / Sun? = Manage Weekday model and table
* StaticPages#Help -> Email the IT Department

## Future releases:
* _auth_admin_timesheet_table => > 10k records needs server-side pull:
  * http://railscasts.com/episodes/340-datatables
