This product is a Time tracking application for the explicit use of West Michigan Refugee Education and Cultural Center. created 2014 by Chiperific.com.

Adjustments from 10/5/14:
* Default date on new timesheet shows orange and pulses. It can't be blank.
* Clicking input-group-addons moves the focus to the next "input"
* fixed error when accessing /users
* "Choose any date within the payperiod" message below payroll_date select

##
Issues:
# Is _timesheet_table doing the math right?
# Issue with Reviewed, Unapproved showing up with an approved date
# Show only unapproved && unreviewed timesheets -- maybe a separate button (for SV and Admin)
# Payroll - Category - breakdown of staff contributions to category in a modal view



# Issue in timeoff (on host/users/1/timeoff/admin):
toh = TimesheetHour.where(user_id: 1).where.not(timeoff_hours: 0).select('timesheet_id, user_id').group(:timesheet_id, :user_id).to_a

is returning [... id: nil ...] -- but why?

th = TimesheetHour.where(timesheet_id = t.id, user_id = u.id )