This product is a Time tracking application for the explicit use of West Michigan Refugee Education and Cultural Center. created 2014 by Chiperific.

## Last completed step:
* Reports: 1.0 Timeoff reports through 'users/#/timeoff/{level}'
* UX validation of hours and cats: progress bars
* Center apps on page
* Frame out payroll view


## Next steps:
* Manage holidays through config page
* show a message on timesheet view when holidays are present
** config to disallow users to work on holidays?

* Calculate workdays in a pay period with consideration for holidays

* Users#edit: auto-hide hourly or salary based upon pay_type

* Finish payroll view
** how to handle unapproved hours?

* Add specs to static_pages_spec#payroll


## Minor tweaks:
* page refreshes on resize (for datatables) because dataTables are not responsive (or at least not with search and display count functions)
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
