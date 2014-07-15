class UpdateToSchema < ActiveRecord::Migration
  def change
    create_table "categories", force: true do |t|
      t.string   "name"
      t.integer  "department_id"
      t.boolean  "active"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "categories", ["department_id"], name: "index_categories_on_department_id"

    create_table "departments", force: true do |t|
      t.string   "name"
      t.boolean  "active"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "requests", force: true do |t|
      t.integer  "user_id"
      t.date     "date"
      t.decimal  "hours",       precision: 4, scale: 2
      t.datetime "created_at"
      t.datetime "updated_at"
      t.boolean  "sv_approval",                         default: false
      t.boolean  "sv_reviewed",                         default: false
    end

    create_table "timesheet_categories", force: true do |t|
      t.integer  "timesheet_id"
      t.integer  "user_id"
      t.integer  "category_id"
      t.decimal  "hours",        precision: 4, scale: 2
      t.boolean  "approved",     default: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "timesheet_categories", ["category_id"], name: "index_timesheet_categories_on_category"
    add_index "timesheet_categories", ["timesheet_id"], name: "index_timesheet_categories_on_timesheet"
    add_index "timesheet_categories", ["user_id"], name: "index_timesheet_categories_on_user"

    create_table "timesheet_hours", force: true do |t|
      t.integer  "timesheet_id"
      t.integer  "user_id"
      t.integer  "weekday"
      t.decimal  "hours",        precision: 4, scale: 2
      t.boolean  "approved",                             default: false
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "timesheet_hours", ["timesheet_id"], name: "index_timesheet_hours_on_timesheet"
    add_index "timesheet_hours", ["user_id"], name: "index_timesheet_hours_on_user"

    create_table "timesheets", force: true do |t|
      t.integer "week_num"
      t.integer "year"
    end

    create_table "users", force: true do |t|
      t.string   "fname"
      t.string   "lname"
      t.boolean  "active"
      t.integer  "department_id"
      t.integer  "supervisor_id"
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "password_digest"
      t.boolean  "admin",                                    default: false
      t.string   "remember_token"
      t.decimal  "annual_time_off", precision: 6,  scale: 2
      t.decimal  "standard_hours",  precision: 6,  scale: 2
      t.decimal  "salary_rate",     precision: 10, scale: 2
      t.decimal  "hourly_rate",     precision: 6,  scale: 2
      t.boolean  "pay_type",                                 default: true
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true
    add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  end
end
