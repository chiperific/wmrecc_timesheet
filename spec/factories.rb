FactoryGirl.define do
  factory :user do
    id                    1
    fname                 "Factory"
    lname                 "User"
    email                 "test@user.com"
    admin                 true
    active                true
    department_id         1
    supervisor_id         2
    password              "foobar"
    password_confirmation "foobar"
  end

  factory :category do
    id            1
    name          "factory category"
    department_id 1
    active        true
  end

  factory :department do
    name          "factory department"
    active        true
    id            1
  end   

  factory :request do
    id            1
    user_id       1
    date          "2014/01/01"
    hours         8
    sv_approval   false
    sv_review     false 
  end
end