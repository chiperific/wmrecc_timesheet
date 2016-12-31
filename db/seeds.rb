# After seeding, reset the IDs (see the reset_ids migration)

Weekday.create!([
  { day_num: 1, app_default_id: 1, name: "Monday",    abbr: "Mon" },
  { day_num: 2, app_default_id: 1, name: "Tuesday",   abbr: "Tues" },
  { day_num: 3, app_default_id: 1, name: "Wednesday", abbr: "Wed" },
  { day_num: 4, app_default_id: 1, name: "Thursday",  abbr: "Thurs" },
  { day_num: 5, app_default_id: 1, name: "Friday",    abbr: "Fri" },
  { day_num: 6, app_default_id: 1, name: "Saturday",  abbr: "Sat" },
  { day_num: 7, app_default_id: 1, name: "Sunday",    abbr: "Sun" }
])

Category.create!([
  { id: 1, name: "Admin", department_id: 1, active: true},
  { id: 2, name: "Vol Svcs", department_id: 1, active: true},
  { id: 3, name: "Tutoring", department_id: 1, active: true},
  { id: 4, name: "Peer Support", department_id: 1, active: true},
  { id: 5, name: "Parent Engagement", department_id: 1, active: true},
  { id: 6, name: "School Engagement", department_id: 1, active: true}
])

Department.create!([
  { name: "All", active: true},
])

AppDefault.create!([
  { name: "Default"}
])

StartMonth.create!([
  { month: "January", app_default_id: 1}
])

TimeoffAccrual.create!([
  { accrual_type: "Annual", app_default_id: 1}
])

PayPeriod.create!([
  { period_type: "Bi-weekly", app_default_id: 1}
])

ItEmail.create!([
  { email: "it_dept@company.com", app_default_id: 1}
])

Holiday.create!([
  { name: "New Year's Day", month: 1, day: 1 },
  { floating: true, name: "M.L. King Jr. Day", month: 1, float_week: 3, float_day: 1 },
  { floating: true, name: "Washington's Birthday", month: 2, float_week: 3, float_day: 1 },
  { floating: true, name: "Memorial Day", month: 5, float_week: 4, float_day: 1 },
  { name: "Independence Day", month: 7, day: 4 },
  { floating: true, name: "Labor Day", month: 9, float_week: 1, float_day: 1 },
  { floating: true, name: "Columbus Day", month: 10, float_week: 2, float_day: 1 },
  { name: "Veterans Day", month: 11, day: 11 },
  { floating: true, name: "Thanksgiving", month: 11, float_week: 4, float_day: 4 },
  { floating: true, name: "Day After Thanksgiving", month: 11, float_week: 4, float_day: 5 },
  { name: "Christmas Day", month: 12, day: 25 }
])

# User.create!([
#   { fname: "Default", lname: "Admin", email: "default@admin.com", active: true, admin: true,  password: "defadmin1", password_confirmation: "defadmin1", time_zone: "Eastern Time (US & Canada)", start_date: "2014/01/01" },
# ])

# For WMRECC_TIMESHEET merger
User.create!([
{id: 1, password: "welcome1", password_confirmation: "welcome1", fname: "Chip",      lname: "Kragt",     active: true,  start_date: "2013-12-31", end_date: nil, department_id: 1,   supervisor_id: 2,   email: "chip@westmirefugee.org",       admin: true,  annual_time_off: 0.0, standard_hours: 0.0,  salary_rate: nil,     hourly_rate: 0.0,  pay_type: "Hourly", time_zone: "Eastern Time (US & Canada)", created_at: "2014-09-17", updated_at: "2015-02-15"},
{id: 2, password: "welcome1", password_confirmation: "welcome1", fname: "Susan",     lname: "Kragt",     active: true,  start_date: "2014-09-17", end_date: nil, department_id: 1,   supervisor_id: nil, email: "susan@westmirefugee.org",      admin: true,  annual_time_off: 0.0, standard_hours: 40.0, salary_rate: 46500.0, hourly_rate: nil,  pay_type: "Salary", time_zone: "Eastern Time (US & Canada)", created_at: "2014-09-17", updated_at: "2015-01-13"},
{id: 3, password: "welcome1", password_confirmation: "welcome1", fname: "Erin",      lname: "Blackwell", active: true,  start_date: "2014-09-17", end_date: nil, department_id: 1,   supervisor_id: 2,   email: "erin@westmirefugee.org",       admin: false, annual_time_off: 0.0, standard_hours: 40.0, salary_rate: 33000.0, hourly_rate: nil,  pay_type: "Salary", time_zone: "Eastern Time (US & Canada)", created_at: "2014-09-17", updated_at: "2015-02-09"},
{id: 4, password: "welcome1", password_confirmation: "welcome1", fname: "Nathaniel", lname: "Harrison",  active: true,  start_date: "2014-09-17", end_date: nil, department_id: 1,   supervisor_id: 2,   email: "nathaniel@westmirefugee.org",  admin: false, annual_time_off: 0.0, standard_hours: 40.0, salary_rate: 31200.0, hourly_rate: nil,  pay_type: "Salary", time_zone: "Eastern Time (US & Canada)", created_at: "2014-09-17", updated_at: "2015-01-13"},
{id: 5, password: "welcome1", password_confirmation: "welcome1", fname: "Salome",    lname: "Campbell",  active: true,  start_date: "2014-09-17", end_date: nil, department_id: 1,   supervisor_id: 2,   email: "salome@westmirefugee.org",     admin: false, annual_time_off: 0.0, standard_hours: 40.0, salary_rate: 30000.0, hourly_rate: 13.0, pay_type: "Salary", time_zone: "Eastern Time (US & Canada)", created_at: "2014-09-17", updated_at: "2015-01-05"},
{id: 6, password: "welcome1", password_confirmation: "welcome1", fname: "Abdi",      lname: "Osman",     active: true,  start_date: "2014-09-17", end_date: nil, department_id: 1,   supervisor_id: 2,   email: "abdi@westmirefugee.org",       admin: false, annual_time_off: 0.0, standard_hours: 40.0, salary_rate: 33500.0, hourly_rate: nil,  pay_type: "Salary", time_zone: "Eastern Time (US & Canada)", created_at: "2014-09-17", updated_at: "2015-02-23"},
{id: 7, password: "welcome1", password_confirmation: "welcome1", fname: "Nathaniel", lname: "Chol",      active: false, start_date: "2014-10-13", end_date: nil, department_id: nil, supervisor_id: 2,   email: "nathanielc@westmirefugee.org", admin: false, annual_time_off: 0.0, standard_hours: 10.0, salary_rate: nil,     hourly_rate: 17.5, pay_type: "Hourly", time_zone: "Eastern Time (US & Canada)", created_at: "2014-10-10", updated_at: "2014-10-27"}
])

# Placeholder for Timesheet.create
Timesheet.create!([
])

# Placeholder for TimesheetHour.create
TimesheetHour.create!([
])

TimesheetCategory.create!([
])

