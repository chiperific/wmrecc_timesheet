FactoryGirl.define do
  factory :user do
    id                    7
    fname                 "Factory"
    lname                 "User"
    email                 "default@admin.com"
    admin                 true
    active                true
    start_date            Date.new(2010, 1, 1)
    department_id         7
    supervisor_id         nil
    password              "defadmin1"
    password_confirmation "defadmin1"
    annual_time_off       158.5
    standard_hours        80
    time_zone             "Eastern Time (US & Canada)"
  end

  factory :users_staff, class: User do
    id                    8
    fname                 "Factory"
    lname                 "User2"
    email                 "active@user.com"
    admin                 true
    active                true
    department_id         7
    supervisor_id         1
    password              "foobar"
    password_confirmation "foobar"
    annual_time_off       158.5
    standard_hours        80
    start_date            Date.new(2010, 1, 1)
    time_zone             "Eastern Time (US & Canada)"
  end

  factory :category do
    id            1
    name          "factory category"
    department_id 7
    active        true
  end

  factory :department do
    id            7
    name          "factory department"
    active        true
  end   


  factory :timesheet do
    id          1
    user_id     7
    start_date  "2015/01/01"
    end_date    "2015/01/07"
  end

  factory :timesheet_hour do
    id             1
    timesheet_id   1
    day_num        2
    hours          7
    timeoff_hours  4.5
  end

  factory :timesheet_category do
    id             1
    timesheet_id   1
    category_id    1
    hours          7
  end

  factory :users_staffs_timesheet, class: Timesheet do
    id          2
    user_id     8
    start_date  "2015/01/01"
    end_date    "2015/01/07"
  end

  factory :users_staffs_timesheet_hour, class: TimesheetHour do
    id             2
    timesheet_id   2
    day_num        2
    hours          7
    timeoff_hours  4.5
  end

  factory :users_staffs_timesheet_category, class: TimesheetCategory do
    id             2
    timesheet_id   2
    category_id    1
    hours          7
  end

  factory :app_default do
    id   1
    name "default"
  end

  factory :weekday do
    name            "Monday"
    abbr            "Mon"
    day_num         1
    app_default_id  1
  end

  factory :it_email do
    email           "it@email.com"
    app_default_id  1
  end

  factory :start_month do
    month           "January"
    app_default_id  1
  end

  factory :timeoff_accrual do
    accrual_type    "Annual"
    app_default_id  1
  end

  factory :pay_period do
    period_type     "Bi-weekly"
    app_default_id  1
  end

  factory :holiday do
    name            "Best Chip Day"
    month           1
    day             "24"
    app_default_id  1
  end
end