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
  {id: 1, fname: "Susan", lname: "Kragt", email: "susan@kragt.com", active: true, admin: true, department_id: 1, supervisor_id: nil, password: "foobar", password_confirmation: "foobar"},
  {id: 2, fname: "Chip", lname: "Kragt", email: "chip@kragt.com", active: true, admin: true, department_id: 1, supervisor_id: 1, password: "foobar", password_confirmation: "foobar"},
  {id: 3, fname: "Inactive", lname: "Admin", email: "inactive@admin.com", active: false, admin: true, department_id: 1, supervisor_id: 2, password: "foobar", password_confirmation: "foobar"},
  {id: 4, fname: "Active", lname: "User", email: "active@user.com", active: true, admin: false, department_id: 1, supervisor_id: 1, password: "foobar", password_confirmation: "foobar"},
  {id: 5, fname: "Active", lname: "User2", email: "active@user2.com", active: true, admin: false, department_id: 1, supervisor_id: 4, password: "foobar", password_confirmation: "foobar"},
  {id: 6, fname: "Inactive", lname: "User", email: "inactive@user.com", active: false, admin: false, department_id: 1, supervisor_id: 1, password: "foobar", password_confirmation: "foobar"}
])
