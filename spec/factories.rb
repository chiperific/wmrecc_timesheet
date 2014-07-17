FactoryGirl.define do
  factory :user do
    fname                 "Factory"
    lname                 "User"
    email                 "chip@kragt.com"
    admin                 true
    active                true
    department_id         1
    supervisor_id         2
    password              "foobar"
    password_confirmation "foobar"
    annual_time_off       158.5
    standard_hours        80
  end

  factory :category do
    name          "factory category"
    department_id 1
    active        true
  end

  factory :department do
    name          "factory department"
    active        true
  end   

  factory :request do
    user_id       1
    date          "2014/01/01"
    hours         8
    sv_approval   false
    sv_reviewed   false 
  end

  factory :timesheet do
    sequence(:week_num)
    sequence(:year, 2007)
  end

  factory :timesheet_hour do
    sequence(:timesheet_id)
    user_id                 1
    sequence(:weekday)
    hours                   7
  end

  factory :timesheet_category do
    timesheet_id  1
    user_id       1
    category_id   1
    hours         7
  end
end