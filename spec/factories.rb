FactoryGirl.define do
  factory :user do
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
    name          "factory category"
    department_id 1
    active        true
  end

  factory :department do
    name          "factory department"
    active        true
  end   
end