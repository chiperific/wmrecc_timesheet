This product is a Time tracking application for the explicit use of West Michigan Refugee Education and Cultural Center. created 2014 by Chiperific.

## Last completed step:
* fix configure error handling
* update 
* create timeoff_accrual model (for app_default)
* create pay_period model (for app_default)
* add start_date and end_date to user and implement

## Next steps:
* update static_pages_spec with it_email and start_month factories

2. draft timeoff views
  * \_single\_timeoff table done
    * needs alert for denied timeoff
  * \_auth\_over\_timeoff and \_auth\_admin\_timeoff need tables
3. timeoff views need sums:
  * timeoff used && remaining between date ranges with 'only approved' || 'all submitted'
4. UX validation of hours and cats
  * Progress bars:
    1. TH.hrs vs. user.standard_hours
    2. TC.hrs vs. TH.hrs
5. Reports
  1.0 Timeoff reports through 'users/#/timeoff/{level}'
  1.1 Timesheet reports through 'users/#/report/{level}'
    * Between dates - s, sv, ad
    * Staff selector - sv, ad
    * TS && TO
  2. http://guides.rubyonrails.org/active_record_querying.html#retrieving-multiple-objects

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


## Setup configurations -- address in configure.html.erb
* Annual timeoff - calendar year vs fiscal year
* TimeZone => application.rb::WmreccTimesheet::config.time_zone
* Include Sat / Sun? = Manage Weekday model and table
* StaticPages#Help -> Email the IT Department

## Future releases:
* _auth_admin_timesheet_table => > 10k records needs server-side pull:
  * http://railscasts.com/episodes/340-datatables
