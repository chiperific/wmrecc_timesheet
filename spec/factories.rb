FactoryGirl.define do
  factory :user do
    id                    1
    fname                 "Factory"
    lname                 "User"
    email                 "susan@kragt.com"
    admin                 true
    active                true
    department_id         1
    supervisor_id         nil
    password              "foobar"
    password_confirmation "foobar"
    annual_time_off       158.5
    standard_hours        80
  end

  factory :users_staff, class: User do
    id                    2
    fname                 "Factory"
    lname                 "User2"
    email                 "chip@kragt.com"
    admin                 true
    active                true
    department_id         1
    supervisor_id         1
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
    timeoff_hours           4.5
  end

  factory :timesheet_category do
    timesheet_id  1
    user_id       1
    category_id   1
    hours         7
  end
end