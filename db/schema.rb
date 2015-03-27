# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150215134320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "app_defaults", force: true do |t|
    t.string "name"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.boolean  "active",        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["department_id"], name: "index_categories_on_department_id", using: :btree

  create_table "departments", force: true do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidays", force: true do |t|
    t.string   "name"
    t.integer  "month"
    t.integer  "day"
    t.integer  "app_default_id", default: 1
    t.boolean  "floating",       default: false
    t.integer  "float_week"
    t.integer  "float_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "it_emails", force: true do |t|
    t.string   "email"
    t.integer  "app_default_id", default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_periods", force: true do |t|
    t.string  "period_type",    default: "Bi-weekly"
    t.integer "app_default_id", default: 1
  end

  create_table "start_months", force: true do |t|
    t.string   "month",          default: "January"
    t.integer  "app_default_id", default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timeoff_accruals", force: true do |t|
    t.string  "accrual_type",   default: "Annual"
    t.integer "app_default_id", default: 1
  end

  create_table "timesheet_categories", force: true do |t|
    t.integer  "timesheet_id"
    t.integer  "category_id"
    t.decimal  "hours",        precision: 4, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timesheet_categories", ["category_id"], name: "index_timesheet_categories_on_category", using: :btree
  add_index "timesheet_categories", ["timesheet_id"], name: "index_timesheet_categories_on_timesheet", using: :btree

  create_table "timesheet_hours", force: true do |t|
    t.integer  "timesheet_id"
    t.integer  "day_num"
    t.decimal  "hours",         precision: 4, scale: 2, default: 0.0
    t.decimal  "timeoff_hours", precision: 4, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timesheet_hours", ["timesheet_id"], name: "index_timesheet_hours_on_timesheet", using: :btree

  create_table "timesheets", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "user_id"
    t.date     "hours_approved"
    t.date     "timeoff_approved"
    t.date     "hours_reviewed"
    t.date     "timeoff_reviewed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "fname"
    t.string   "lname"
    t.boolean  "active",                                   default: true
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "department_id"
    t.integer  "supervisor_id"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",                                    default: false
    t.decimal  "annual_time_off", precision: 6,  scale: 2, default: 0.0
    t.decimal  "standard_hours",  precision: 6,  scale: 2, default: 40.0
    t.decimal  "salary_rate",     precision: 10, scale: 2
    t.decimal  "hourly_rate",     precision: 6,  scale: 2
    t.string   "pay_type",                                 default: "Salary"
    t.string   "time_zone",                                default: "Eastern Time (US & Canada)"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "weekdays", force: true do |t|
    t.integer "app_default_id", default: 1
    t.string  "name"
    t.string  "abbr"
    t.integer "day_num"
  end

end
