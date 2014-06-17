Category.create!([
  {id: 1, name: "Website maintenance", department_id: 2, active: 1},
  {id: 2, name: "Software updates", department_id: 2, active: 1},
  {id: 3, name: "Fundraising", department_id: 1, active: 1},
  {id: 4, name: "Management", department_id: 1, active: 1},
  {id: 5, name: "Board Development", department_id: 1, active: 1},
  {id: 6, name: "Software development", department_id: 2, active: 1},
  {id: 7, name: "Finance", department_id: 1, active: 1},
  {id: 8, name: "Tutoring", department_id: 4, active: 1}
])
Department.create!([
  {id: 1, name: "Exec", active: 1},
  {id: 2, name: "IT", active: 1},
  {id: 3, name: "Lobbying", active: 0},
  {id: 4, name: "Student Programs", active: 1},
  {id: 5, name: "Transportation", active: 0},
  {id: 6, name: "School Impact", active: 1},
  {id: 7, name: "Adult engagement", active: 1},
  {id: 8, name: "New Dep", active: 1},
  {id: 9, name: "Educator outreach", active: 1}
])
User.create!([
  {id: 1, fname: "Susan", lname: "Kragt", email: "susan@kragt.com", active: 1, admin: 1, department_id: 1, supervisor_id: nil, password: "foobar", password_confirmation: "foobar"},
  {id: 2, fname: "Chip", lname: "Kragt", email: "chip@kragt.com", active: 1, admin: 1, department_id: 2, supervisor_id: 1, password: "foobar", password_confirmation: "foobar"},
  {id: 3, fname: "Inactive", lname: "Admin", email: "inactive@admin.com", active: 0, admin: 1, department_id: 2, supervisor_id: 2, password: "foobar", password_confirmation: "foobar"},
  {id: 4, fname: "Active", lname: "User", email: "active@user.com", active: 1, admin: 0, department_id: 4, supervisor_id: 1, password: "foobar", password_confirmation: "foobar"},
  {id: 5, fname: "Active", lname: "User2", email: "active@user2.com", active: 1, admin: 0, department_id: 4, supervisor_id: 4, password: "foobar", password_confirmation: "foobar"},
  {id: 6, fname: "Inactive", lname: "User", email: "inactive@user.com", active: 0, admin: 0, department_id: 7, supervisor_id: 1, password: "foobar", password_confirmation: "foobar"}
])
