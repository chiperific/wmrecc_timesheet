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
  { name: "Admin", department_id: 1, active: true},
  { name: "Vol Svcs", department_id: 1, active: true},
  { name: "Tutoring", department_id: 1, active: true},
  { name: "Peer Support", department_id: 1, active: true},
  { name: "Parent Engagement", department_id: 1, active: true},
  { name: "School Engagement", department_id: 1, active: true}
])

Department.create!([
  { name: "All", active: true},
])

User.create!([
  { fname: "Default", lname: "Admin", email: "default@admin.com", active: true, admin: true,  password: "defadmin1", password_confirmation: "defadmin1", time_zone: "Eastern Time (US & Canada)", start_date: "2014/01/01" },
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
