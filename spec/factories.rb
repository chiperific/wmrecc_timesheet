FactoryGirl.define do
  factory :user do
    fname                 "Chip"
    lname                 "Kragt"
    email                 "chiperific@gmail.com"
    admin                 true
    active                true
    department_id         1
    supervisor_id         2
    password              "ghalecrow"
    password_confirmation "ghalecrow"
  end
end