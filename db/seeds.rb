Weekday.create!([
  {id: 1 ,day_num: 1, app_default_id: 1, name: "Monday",    abbr: "Mon" },
  {id: 2 ,day_num: 2, app_default_id: 1, name: "Tuesday",   abbr: "Tues" }, 
  {id: 3 ,day_num: 3, app_default_id: 1, name: "Wednesday", abbr: "Wed" }, 
  {id: 4 ,day_num: 4, app_default_id: 1, name: "Thursday",  abbr: "Thurs" }, 
  {id: 5 ,day_num: 5, app_default_id: 1, name: "Friday",    abbr: "Fri" }, 
  {id: 6 ,day_num: 6, app_default_id: 1, name: "Saturday",  abbr: "Sat" }, 
  {id: 7 ,day_num: 7, app_default_id: 1, name: "Sunday",    abbr: "Sun" }
])

Category.create!([
  {id: 1, name: "Admin", department_id: 1, active: true},
  {id: 2, name: "Vol Svcs", department_id: 1, active: true},
  {id: 3, name: "Tutoring", department_id: 1, active: true},
  {id: 4, name: "Peer Support", department_id: 1, active: true},
  {id: 5, name: "Parent Engagement", department_id: 1, active: true},
  {id: 6, name: "School Engagement", department_id: 1, active: true}
])

Department.create!([
  {id: 1, name: "All", active: true},
])

User.create!([
  {id: 3, fname: "Default", lname: "Admin", email: "default@admin.com", active: true, admin: true,  password: "defadmin1", password_confirmation: "defadmin1", time_zoone: "Eastern Time (US & Canada)" },
])

AppDefault.create!([
  {id: 1, name: "Default"}
])

StartMonth.create!([
  {id: 1, month: "January", app_default_id: 1}
])

ItEmail.create!([
  {id: 1, email: "it@email.com", app_default_id: 1}
])

TimeoffAccrual.create!([
  {id: 1, accrual_type: "Annual", app_default_id: 1}
])

PayPeriod.create!([
  {id: 1, period_type: "Bi-weekly", app_default_id: 1}
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
