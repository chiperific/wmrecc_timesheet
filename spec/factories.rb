FactoryGirl.define do
  factory :user do
    id                    1
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


  factory :timesheet do
    id              1
    week_num        26
    year            2014
  end

  factory :timesheet_hour do
    timesheet_id            1
    user_id                 1
    weekday                 2
    hours                   7
  end

  factory :timesheet_category do
    timesheet_id  1
    user_id       1
    category_id   1
    hours         7
  end
end