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
end